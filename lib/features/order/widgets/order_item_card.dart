import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tcean/models/cart_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/product_model.dart';

Widget orderItemCard({required BuildContext context, required CartModel cart}) {
  var product = products
      .where(
        (element) => element.productID == cart.productID,
      )
      .first;
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: product.productImageUrls.first,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            placeholder: (context, url) => const Text("tcean.store"),
            errorWidget: (context, url, error) => const Text("tcean.store"),
          ),
        ),
        8.widthBox,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
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
              Text(
                "${cart.quantity} pcs",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ).pOnly(
      left: 8,
    ),
  );
}
