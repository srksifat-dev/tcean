import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tcean/models/order.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderCard({required BuildContext context, required Order order}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.orderID,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            IconButton(
                onPressed: () {
                  final data = ClipboardData(text: order.orderID);
                  Clipboard.setData(data);
                  Fluttertoast.showToast(
                      msg: "Order ID is copied in clipboard!");
                },
                icon: Icon(Icons.copy))
          ],
        ),
        Text(
          order.orderTime,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: ${order.orderExpense + order.deliveryCharge}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Chip(label: Text("label"))
          ],
        )
      ],
    ).px(16),
  );
}
