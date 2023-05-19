import 'package:flutter/material.dart';
import 'package:tcean/models/cart.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderItemCard({required BuildContext context, required Cart cart}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          cart.product.productImageUrls.first,
          height: 100,
        ),
        8.widthBox,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.productName,
              style: Theme.of(context).textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              "Color: ${cart.color}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              "Size: ${cart.size}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    ).pOnly(
      left: 16,
    ),
  );
}
