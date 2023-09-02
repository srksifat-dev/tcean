import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/core/utils.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:tcean/features/auth/controller/auth_controller.dart';
import 'package:tcean/features/auth/screens/auth_screen.dart';
import 'package:tcean/features/user/controller/withdraw_controller.dart';
import 'package:tcean/main.dart';
import 'package:tcean/models/address_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/checkout_textfield.dart';
import '../../../core/common/editable_card.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  TextEditingController contactNumberController = TextEditingController();
  FocusNode contactNumberFocusNode = FocusNode();

  String emailAddress = "you@email.com";
  TextEditingController addressNameController = TextEditingController();
  FocusNode addressNameFocusNode = FocusNode();
  TextEditingController districtController = TextEditingController();
  FocusNode districtFocusNode = FocusNode();
  TextEditingController areaController = TextEditingController();
  FocusNode areaFocusNode = FocusNode();
  TextEditingController detailsController = TextEditingController();
  FocusNode detailsFocusNode = FocusNode();
  List<AddressModel> _addressList = [];

  bool _isBackPressed = false;

  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      // If already pressed once, exit the app
      return true;
    }

    _isBackPressed = true;
    _showSnackBar('Press back again to exit');

    Timer(const Duration(seconds: 2), () {
      // Reset the flag after 2 seconds
      _isBackPressed = false;
    });

    return false;
  }

  void _showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    if (userModel != null) {
      contactNumberController.text = userModel!.phoneNumber ?? "01XXXXXXXXX";
      emailAddress = userModel!.email!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            return WillPopScope(
              onWillPop: _onWillPop,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: mainAppBar(context: context,ref: ref),
                body: data != null
                    ? SingleChildScrollView(
                        child: ref.watch(getUserDataProvider(data.uid)).when(
                              data: (userData) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  editableCard(
                                    context: context,
                                    sectionTitle: "Name",
                                    title: Text(userModel!.name ?? "Your Name"),
                                    onTap: () {},
                                  ),
                                  editableCard(
                                    context: context,
                                    sectionTitle: "Contact Number",
                                    title: Text(userData.phoneNumber!),
                                    trailing: const Icon(Icons.edit),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: CheckoutTextfield(
                                                controller:
                                                    contactNumberController,
                                                focusNode:
                                                    contactNumberFocusNode,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                textInputType:
                                                    TextInputType.phone,
                                                hintText:
                                                    contactNumberController
                                                        .text,
                                                autoFocus: true,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      GoRouter.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("cancel")),
                                                FilledButton(
                                                    onPressed: () {
                                                      ref
                                                          .watch(
                                                              authControllerProvider
                                                                  .notifier)
                                                          .editUserPhoneNumber(
                                                            uid: userModel!.uid,
                                                            userPhoneNumber:
                                                                contactNumberController
                                                                    .text,
                                                          );
                                                      GoRouter.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Update")),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  editableCard(
                                    context: context,
                                    sectionTitle: "Email Address",
                                    title: Text(emailAddress),
                                    onTap: () {},
                                  ),
                                  userModel!.balance != 0
                                      ? Container()
                                      : editableCard(
                                          context: context,
                                          sectionTitle: "Tcean Balance",
                                          title: Text(
                                            "৳ ${userModel!.balance.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          trailing: TextButton(
                                              onPressed: () {
                                                if (userModel!.balance < 1000) {
                                                  context.pushNamed(
                                                      RouteConst.kWithdraw);
                                                } else {
                                                  showSnackBar(context,
                                                      "Minimum amount to withdraw money is 1000 BDT");
                                                }
                                              },
                                              child: userModel!
                                                          .lastWithdrawID !=
                                                      null
                                                  ? ref
                                                      .watch(getWithdrawRequestProvider(
                                                          userModel!
                                                              .lastWithdrawID!))
                                                      .when(
                                                        data: (data) => Text(
                                                            data.withdrawStatus),
                                                        error: (error,
                                                                stackTrace) =>
                                                            const Text(
                                                                "Withdrawal Request"),
                                                        loading: () => const Loader(),
                                                      )
                                                  : const Text("Withdrawal Request")),
                                          onTap: () {}),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Addresses"),
                                      TextButton.icon(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CheckoutTextfield(
                                                        controller:
                                                            addressNameController,
                                                        focusNode:
                                                            addressNameFocusNode,
                                                        hintText:
                                                            "Address Name(Ex. Home)",
                                                        textInputType:
                                                            TextInputType.text,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                      ),
                                                      16.heightBox,
                                                      CheckoutTextfield(
                                                        controller:
                                                            districtController,
                                                        focusNode:
                                                            districtFocusNode,
                                                        hintText: "District",
                                                        textInputType:
                                                            TextInputType.text,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                      ),
                                                      16.heightBox,
                                                      CheckoutTextfield(
                                                        controller:
                                                            areaController,
                                                        focusNode:
                                                            areaFocusNode,
                                                        hintText:
                                                            "Area/Thana/Upozilla",
                                                        textInputType:
                                                            TextInputType.text,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                      ),
                                                      16.heightBox,
                                                      CheckoutTextfield(
                                                        controller:
                                                            detailsController,
                                                        focusNode:
                                                            detailsFocusNode,
                                                        hintText:
                                                            "Details Address",
                                                        textInputType:
                                                            TextInputType
                                                                .multiline,
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          GoRouter.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text("cancel")),
                                                    FilledButton(
                                                        onPressed: () {
                                                          ref
                                                              .watch(
                                                                  authControllerProvider
                                                                      .notifier)
                                                              .addAddress(
                                                                uid: userModel!
                                                                    .uid,
                                                                address:
                                                                    AddressModel(
                                                                  addressName:
                                                                      addressNameController
                                                                          .text,
                                                                  district:
                                                                      districtController
                                                                          .text,
                                                                  area:
                                                                      areaController
                                                                          .text,
                                                                  detailsAddress:
                                                                      detailsController
                                                                          .text,
                                                                  defaultIndex:
                                                                      _addressList
                                                                          .length,
                                                                ),
                                                              );
                                                          GoRouter.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text("Add")),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(Icons.add_location_alt),
                                        label: const Text("Add"),
                                      )
                                    ],
                                  ),
                                  ref
                                      .watch(getAddressesProvider(userData.uid))
                                      .when(
                                        data: (addresses) {
                                          List<AddressModel> reversedList = [];
                                          reversedList =
                                              addresses.reversed.toList();
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Column(
                                              children: reversedList
                                                  .map((e) => Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        child: RadioListTile(
                                                          title: Text(
                                                            e.addressName!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                          subtitle: Text(
                                                            "${e.detailsAddress}, ${e.area}, ${e.district}",
                                                          ),
                                                          value: reversedList
                                                              .indexOf(e),
                                                          groupValue:
                                                              e.defaultIndex,
                                                          onChanged: (value) {
                                                            ref
                                                                .watch(
                                                                    authControllerProvider
                                                                        .notifier)
                                                                .setAsDefaultAddress(
                                                                    uid: userData
                                                                        .uid,
                                                                    defaultIndex:
                                                                        value!);
                                                          },
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          );
                                        },
                                        // SizedBox(
                                        //   height: reversedList.length * 120,
                                        //   child: ListView.builder(
                                        //       physics:
                                        //           NeverScrollableScrollPhysics(),
                                        //       itemCount: reversedList.length,
                                        //       itemBuilder: (context, index) {
                                        //         _addressList = reversedList;
                                        //         return Card(
                                        //           shape: RoundedRectangleBorder(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       16)),
                                        //           child: CheckboxListTile(
                                        //             title: Text(
                                        //               reversedList[index]
                                        //                   .addressName,
                                        //               style: Theme.of(context)
                                        //                   .textTheme
                                        //                   .titleSmall,
                                        //             ),
                                        //             subtitle: Text(
                                        //               "${reversedList[index].detailsAddress}, ${reversedList[index].area}, ${reversedList[index].district}",
                                        //             ),
                                        //             value: reversedList[index]
                                        //                 .isDefault,
                                        //             onChanged: (value) {
                                        //               ref
                                        //                   .watch(
                                        //                       authControllerProvider
                                        //                           .notifier)
                                        //                   .setAsDefaultAddress(
                                        //                       uid: userData.uid,
                                        //                       isDefault: value
                                        //                           as bool);
                                        //             },
                                        //           ),
                                        //         );
                                        //       }),
                                        // ),
                                        error: (error, stackTrace) =>
                                            ErrorText(error: error.toString()),
                                        loading: () => const Loader(),
                                      ),

                                  // editableCard(
                                  //   context: context,
                                  //   sectionTitle: "reversedList",
                                  //   subtitle:
                                  //       ref
                                  //           .watch(getAddressesProvider(
                                  //               userData.uid))
                                  //           .when(
                                  //             data: (data) {
                                  //               if (data == null) {
                                  //                 return TextButton.icon(
                                  //                   onPressed: () {
                                  //                     showDialog(
                                  //                         context: context,
                                  //                         builder: (context) {
                                  //                           return AlertDialog(
                                  //                             content: Column(
                                  //                               mainAxisSize:
                                  //                                   MainAxisSize
                                  //                                       .min,
                                  //                               children: [
                                  //                                 CheckoutTextfield(
                                  //                                   controller:
                                  //                                       addressNameController,
                                  //                                   focusNode:
                                  //                                       addressNameFocusNode,
                                  //                                   hintText:
                                  //                                       "Address Name(Ex. Home)",
                                  //                                   textInputType:
                                  //                                       TextInputType
                                  //                                           .text,
                                  //                                   textCapitalization:
                                  //                                       TextCapitalization
                                  //                                           .words,
                                  //                                 ),
                                  //                                 16.heightBox,
                                  //                                 CheckoutTextfield(
                                  //                                   controller:
                                  //                                       districtController,
                                  //                                   focusNode:
                                  //                                       districtFocusNode,
                                  //                                   hintText:
                                  //                                       "District",
                                  //                                   textInputType:
                                  //                                       TextInputType
                                  //                                           .text,
                                  //                                   textCapitalization:
                                  //                                       TextCapitalization
                                  //                                           .words,
                                  //                                 ),
                                  //                                 16.heightBox,
                                  //                                 CheckoutTextfield(
                                  //                                   controller:
                                  //                                       areaController,
                                  //                                   focusNode:
                                  //                                       areaFocusNode,
                                  //                                   hintText:
                                  //                                       "Area/Thana/Upozilla",
                                  //                                   textInputType:
                                  //                                       TextInputType
                                  //                                           .text,
                                  //                                   textCapitalization:
                                  //                                       TextCapitalization
                                  //                                           .words,
                                  //                                 ),
                                  //                                 16.heightBox,
                                  //                                 CheckoutTextfield(
                                  //                                   controller:
                                  //                                       detailsController,
                                  //                                   focusNode:
                                  //                                       detailsFocusNode,
                                  //                                   hintText:
                                  //                                       "Details Address",
                                  //                                   textInputType:
                                  //                                       TextInputType
                                  //                                           .multiline,
                                  //                                   textCapitalization:
                                  //                                       TextCapitalization
                                  //                                           .words,
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                             actions: [
                                  //                               TextButton(
                                  //                                   onPressed:
                                  //                                       () {
                                  //                                     GoRouter.of(
                                  //                                             context)
                                  //                                         .pop();
                                  //                                   },
                                  //                                   child: Text(
                                  //                                       "cancel")),
                                  //                               FilledButton(
                                  //                                   onPressed:
                                  //                                       () {
                                  //                                     ref
                                  //                                         .watch(
                                  //                                             authControllerProvider.notifier)
                                  //                                         .addAddress(
                                  //                                           uid:
                                  //                                               userModel!.uid,
                                  //                                           address:
                                  //                                               AddressModel(
                                  //                                             addressName: addressNameController.text,
                                  //                                             district: districtController.text,
                                  //                                             area: areaController.text,
                                  //                                             detailsAddress: detailsController.text,
                                  //                                             isDefault: data.length == 0 ? true : false,
                                  //                                           ),
                                  //                                         );
                                  //                                     GoRouter.of(
                                  //                                             context)
                                  //                                         .pop();
                                  //                                   },
                                  //                                   child: Text(
                                  //                                       "Add")),
                                  //                             ],
                                  //                           );
                                  //                         });
                                  //                   },
                                  //                   icon: Icon(
                                  //                       Icons.add_location_alt),
                                  //                   label: Text(
                                  //                       "Add Your Address"),
                                  //                 );
                                  //               } else {
                                  //                 return Column(
                                  //                   children: [
                                  //                     Expanded(
                                  //                       child:
                                  //                           ListView.separated(
                                  //                         itemCount:
                                  //                             data.length,
                                  //                         itemBuilder:
                                  //                             (context, index) {
                                  //                           return Card(
                                  //                             child: ListTile(
                                  //                               title: Text(
                                  //                                 data[index]
                                  //                                     .addressName,
                                  //                                 style: Theme.of(
                                  //                                         context)
                                  //                                     .textTheme
                                  //                                     .bodySmall!
                                  //                                     .copyWith(
                                  //                                       fontWeight:
                                  //                                           FontWeight.bold,
                                  //                                     ),
                                  //                               ),
                                  //                               subtitle:
                                  //                                   RichText(
                                  //                                       text: TextSpan(
                                  //                                           children: [
                                  //                                     TextSpan(
                                  //                                       text:
                                  //                                           "${data[index].detailsAddress}, ${data[index].area}, ${data[index].district}",
                                  //                                       style: Theme.of(context)
                                  //                                           .textTheme
                                  //                                           .bodySmall,
                                  //                                     ),
                                  //                                   ])),
                                  //                             ),
                                  //                           );
                                  //                         },
                                  //                         separatorBuilder:
                                  //                             (_, __) =>
                                  //                                 8.heightBox,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 );
                                  //               }
                                  //             },
                                  //             error: (error, stackTrace) =>
                                  //                 ErrorText(
                                  //                     error: error.toString()),
                                  //             loading: () => Loader(),
                                  //           ),
                                  //   trailing: Icon(Icons.location_city),
                                  //   additionalButtonIcon: Icons.location_on,
                                  //   additionalButtonLabel: "Add Address",
                                  //   onTap: () {
                                  //     showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return AlertDialog(
                                  //             content: Column(
                                  //               mainAxisSize: MainAxisSize.min,
                                  //               children: [
                                  //                 CheckoutTextfield(
                                  //                   controller:
                                  //                       addressNameController,
                                  //                   focusNode:
                                  //                       addressNameFocusNode,
                                  //                   hintText:
                                  //                       "Address Name(Ex. Home)",
                                  //                   textInputType:
                                  //                       TextInputType.text,
                                  //                   textCapitalization:
                                  //                       TextCapitalization
                                  //                           .words,
                                  //                 ),
                                  //                 16.heightBox,
                                  //                 CheckoutTextfield(
                                  //                   controller:
                                  //                       districtController,
                                  //                   focusNode:
                                  //                       districtFocusNode,
                                  //                   hintText: "District",
                                  //                   textInputType:
                                  //                       TextInputType.text,
                                  //                   textCapitalization:
                                  //                       TextCapitalization
                                  //                           .words,
                                  //                 ),
                                  //                 16.heightBox,
                                  //                 CheckoutTextfield(
                                  //                   controller: areaController,
                                  //                   focusNode: areaFocusNode,
                                  //                   hintText:
                                  //                       "Area/Thana/Upozilla",
                                  //                   textInputType:
                                  //                       TextInputType.text,
                                  //                   textCapitalization:
                                  //                       TextCapitalization
                                  //                           .words,
                                  //                 ),
                                  //                 16.heightBox,
                                  //                 CheckoutTextfield(
                                  //                   controller:
                                  //                       detailsController,
                                  //                   focusNode: detailsFocusNode,
                                  //                   hintText: "Details Address",
                                  //                   textInputType:
                                  //                       TextInputType.multiline,
                                  //                   textCapitalization:
                                  //                       TextCapitalization
                                  //                           .words,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                   onPressed: () {
                                  //                     GoRouter.of(context)
                                  //                         .pop();
                                  //                   },
                                  //                   child: Text("cancel")),
                                  //               FilledButton(
                                  //                   onPressed: () {
                                  //                     ref
                                  //                         .watch(
                                  //                             authControllerProvider
                                  //                                 .notifier)
                                  //                         .addAddress(
                                  //                           uid: userModel!.uid,
                                  //                           address:
                                  //                               AddressModel(
                                  //                             addressName:
                                  //                                 addressNameController
                                  //                                     .text,
                                  //                             district:
                                  //                                 districtController
                                  //                                     .text,
                                  //                             area:
                                  //                                 areaController
                                  //                                     .text,
                                  //                             detailsAddress:
                                  //                                 detailsController
                                  //                                     .text,
                                  //                             isDefault:
                                  //                                 _addressList.length ==
                                  //                                         0
                                  //                                     ? true
                                  //                                     : false,
                                  //                           ),
                                  //                         );
                                  //                     GoRouter.of(context)
                                  //                         .pop();
                                  //                   },
                                  //                   child: Text("Add")),
                                  //             ],
                                  //           );
                                  //         });
                                  //   },
                                  // ),
                                  editableCard(
                                    context: context,
                                    title: const Text("Orders"),
                                    trailing: const Icon(Icons.shopping_bag),
                                    onTap: () {
                                      context.pushNamed(RouteConst.kOrders);
                                    },
                                  ),
                                  // Spacer(),
                                  FilledButton.icon(
                                      onPressed: () {
                                        ref
                                            .read(
                                                authControllerProvider.notifier)
                                            .logout();
                                      },
                                      icon: const Icon(Icons.logout),
                                      label: const Text("Log Out"))
                                ],
                              ).px(16),
                              error: (error, stackTrace) =>
                                  ErrorText(error: error.toString()),
                              loading: () => const Loader(),
                            ),
                      )
                    : const AuthScreen(),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
