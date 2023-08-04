import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/core/common/phone_number_textfield.dart';
import 'package:tcean/features/user/controller/withdraw_controller.dart';
import 'package:tcean/main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/utils.dart';

List<String> withdrawMethods = [
  "bKash",
  "Nagad",
  "Rocket",
  "Upay",
];
List<Color> colors = [
  const Color(0xffE2136E),
  const Color(0xffEB2127),
  const Color(0xff8A288F),
  const Color(0xffFED500),
];

class WithdrawScreen extends ConsumerStatefulWidget {
  WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  String selectedMethod = withdrawMethods[0];

  TextEditingController gatewayNumberController = TextEditingController();
  FocusNode gatewayNumberFocusNode = FocusNode();

  TextEditingController amountController = TextEditingController();
  FocusNode amountFocusNode = FocusNode();
  String withdrawStatus = "Withdrawal Request";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isMoreThanThousand = true;
  @override
  void initState() {
    amountController.text = 1000.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gatewayNumberFocusNode.unfocus();
        amountFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Withdraw"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Choice Payment Getway"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: withdrawMethods
                    .map((e) => ActionChip(
                          backgroundColor: selectedMethod == e
                              ? colors[withdrawMethods.indexOf(e)]
                              : Colors.transparent,
                          label: Text(e),
                          onPressed: () {
                            setState(() {
                              selectedMethod = e;
                            });
                          },
                        ))
                    .toList(),
              ),
              16.heightBox,
              const Text("Gateway Number"),
              const Text(
                "(the number used to open the account)",
                style: TextStyle(fontSize: 15),
              ),
              8.heightBox,
              PhoneNumberTextfield(
                controller: gatewayNumberController,
                focusNode: gatewayNumberFocusNode,
                formKey: formKey,
              ),
              16.heightBox,
              const Text("Withdrawal Amount"),
              const Text(
                "(Have to be minimum 1000)",
                style: TextStyle(fontSize: 15),
              ),
              8.heightBox,
              TextField(
                controller: amountController,
                focusNode: amountFocusNode,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) >= 1000) {
                      setState(() {
                        isMoreThanThousand = true;
                      });
                    } else {
                      setState(() {
                        isMoreThanThousand = false;
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                keyboardType: TextInputType.number,
              ),
              32.heightBox,
              isMoreThanThousand
                  ? FilledButton(
                      onPressed: () {
                        formKey.currentState!.validate()
                            ? ref
                                .watch(withdrawControllerProvider)
                                .requestForWithdraw(
                                  context: context,
                                  withdrawID: DateTime.now().toString().trim(),
                                  date: DateTime.now().toString(),
                                  uid: userModel!.uid,
                                  amount: int.parse(amountController.text),
                                  paymentMethod: selectedMethod,
                                  gatewayNumber: gatewayNumberController.text,
                                  withdrawStatus: "Withdrawal Requested",
                                )
                            : showSnackBar(
                                context, "Enter valid gateway number!");
                      },
                      child: Text(withdrawStatus),
                    )
                  : Container(),
            ],
          ).px(16),
        ),
      ),
    );
  }
}
