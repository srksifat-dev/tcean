import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Column(
        children: [
          Text("Pay in your suitable payment method"),
          InkWell(
            radius: 16,
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/bkash.svg",
                    height: 56,
                  ),
                  16.widthBox,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Pay through ",
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: "bKash",
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                ],
              ).p(16),
            ),
          ),
          InkWell(
            radius: 16,
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/nagad.svg",
                    height: 56,
                  ),
                  16.widthBox,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Pay through ",
                            style: Theme.of(context).textTheme.bodyMedium),
                        TextSpan(
                            text: "Nagad",
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                ],
              ).p(16),
            ),
          ),
        ],
      ).px(16),
    );
  }
}
