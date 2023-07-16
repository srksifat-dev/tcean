import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/dummy/dummy_address.dart';
import 'package:tcean/routes/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/common/checkout_textfield.dart';
import '../../../core/common/editable_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController districtController = TextEditingController();
  FocusNode districtFocusNode = FocusNode();
  TextEditingController areaController = TextEditingController();
  FocusNode areaFocusNode = FocusNode();
  TextEditingController detailsController = TextEditingController();
  FocusNode detailsFocusNode = FocusNode();
  String name = "Your name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          editableCard(
              context: context,
              subtitle: Text(name),
              icon: Icons.edit,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: CheckoutTextfield(
                          controller: nameController,
                          focusNode: nameFocusNode,
                          textCapitalization: TextCapitalization.words,
                          textInputType: TextInputType.name,
                          hintText: "Your Name",
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: Text("cancel")),
                          FilledButton(
                              onPressed: () {
                                setState(() {
                                  name = nameController.text;
                                });
                                GoRouter.of(context).pop();
                              },
                              child: Text("Update")),
                        ],
                      );
                    });
              }),
          editableCard(
              context: context,
              subtitle: Text("Phone Number"),
              icon: Icons.phone,
              onTap: () {}),
          editableCard(
              context: context,
              title: "My Balance",
              subtitle: Text(
                "৳300.00",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              icon: Icons.download,
              onTap: () {}),
          editableCard(
              context: context,
              title: "Addresses",
              subtitle: dummyAddress.isEmpty
                  ? TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CheckoutTextfield(
                                      controller: districtController,
                                      focusNode: districtFocusNode,
                                      hintText: "District",
                                      textInputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                    16.heightBox,
                                    CheckoutTextfield(
                                      controller: areaController,
                                      focusNode: areaFocusNode,
                                      hintText: "Area/Thana/Upozilla",
                                      textInputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                    16.heightBox,
                                    CheckoutTextfield(
                                      controller: detailsController,
                                      focusNode: detailsFocusNode,
                                      hintText: "Details Address",
                                      textInputType: TextInputType.multiline,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      child: Text("cancel")),
                                  FilledButton(
                                      onPressed: () {
                                        GoRouter.of(context).pop();
                                      },
                                      child: Text("Update")),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.add_location_alt),
                      label: Text("Add Your Address"))
                  : Column(
                      children: [
                        SizedBox(
                          height: dummyAddress.length * 64,
                          child: ListView.separated(
                            itemCount: dummyAddress.length,
                            itemBuilder: (context, index) {
                              return RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: "${dummyAddress[index].addressName} : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      "${dummyAddress[index].detailsAddress}, ${dummyAddress[index].area}, ${dummyAddress[index].district}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ]));
                            },
                            separatorBuilder: (_, __) => 8.heightBox,
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CheckoutTextfield(
                                            controller: districtController,
                                            focusNode: districtFocusNode,
                                            hintText: "District",
                                            textInputType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
                                          16.heightBox,
                                          CheckoutTextfield(
                                            controller: areaController,
                                            focusNode: areaFocusNode,
                                            hintText: "Area/Thana/Upozilla",
                                            textInputType: TextInputType.text,
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
                                          16.heightBox,
                                          CheckoutTextfield(
                                            controller: detailsController,
                                            focusNode: detailsFocusNode,
                                            hintText: "Details Address",
                                            textInputType:
                                                TextInputType.multiline,
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              GoRouter.of(context).pop();
                                            },
                                            child: Text("cancel")),
                                        FilledButton(
                                            onPressed: () {
                                              GoRouter.of(context).pop();
                                            },
                                            child: Text("Update")),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.add_location_alt),
                            label: Text("Add Your Address"))
                      ],
                    ),
              icon: Icons.location_city,
              onTap: () {}),
          editableCard(
              context: context,
              title: "Orders",
              icon: Icons.shopping_bag,
              onTap: () {
                context.pushNamed(RouteConst.kOrders);
              }),
        ],
      ).px(16),
    );
  }
}
