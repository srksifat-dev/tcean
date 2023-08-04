import 'package:flutter/material.dart';
import 'package:tcean/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/cart_model.dart';

Widget hProductCard({
  required BuildContext context,
  required ProductModel product,
  int? discountAmount,
  int? discountPercentage,
  int? salePrice,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Image.asset(
          product.productImageUrls.first,
          height: 100,
        ),
        8.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              discountAmount != null || discountPercentage != null? Row(
                children: [
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  discountAmount != null
                      ? Text((product.price - discountAmount).toString())
                      : Container(),
                  discountPercentage != null
                      ? Text(
                          ((product.price * (discountPercentage / 100)).toInt())
                              .toString())
                      : Container(),
                ],
              ) : Container(),
              salePrice != null ? Text(salePrice.toString()) : Container(),
            ],
          ),
        ),
      ],
    ).pOnly(
      left: 16,
    ),
  );
}
