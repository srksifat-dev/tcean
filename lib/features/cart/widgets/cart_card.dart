import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcean/features/cart/controller/cart_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

Widget cartCard(
    {required BuildContext context,
    required CartModel cart,
    required int productPrice,
    required WidgetRef ref}) {
  var product = products
      .where(
        (element) => element.productID == cart.productID,
      )
      .first;
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            key: UniqueKey(),
            imageUrl: product.productImageUrls.first,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
            placeholder: (context, url) => const Text("tcean.store"),
            errorWidget: (context, url, error) => const Text("tcean.store"),
          ),
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
            IconButton(
                onPressed: () {
                  ref.watch(cartControllerProvider).removeQuantity(
                        cartID: cart.cartID,
                        productPrice: productPrice,
                      );
                },
                icon: const Icon(Icons.remove)),
            AnimatedFlipCounter(
              value: cart.quantity,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(
                onPressed: () {
                  ref.watch(cartControllerProvider).addQuantity(
                        cartID: cart.cartID,
                        productPrice: productPrice,
                      );
                },
                icon: const Icon(Icons.add))
          ],
        )
      ],
    ).pOnly(
      left: 8,
    ),
  );
}
