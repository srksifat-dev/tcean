import 'package:flutter/material.dart';
import 'package:tcean/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/cart.dart';

Widget cartCard({required BuildContext context, required Cart cart}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Image.asset(
          cart.product.productImageUrls.first,
          height: 100,
        ),
        8.widthBox,
        Expanded(
          child: Column(
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
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
            Text(
              "${cart.quantity.toString()}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.add))
          ],
        )
      ],
    ).pOnly(
      left: 16,
    ),
  );
}
