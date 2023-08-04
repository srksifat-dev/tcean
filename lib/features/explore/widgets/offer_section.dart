import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/horizontal_product_card.dart';
import '../../../core/common/product_card.dart';
import '../../../models/coupon_model.dart';
import '../../../models/product_model.dart';
import '../../products/controller/products_controller.dart';
import 'coupon_details.dart';

Widget offerSection({
  required BuildContext context,
  required CouponModel coupon,
  required WidgetRef ref,
}) {
  if (coupon.couponType == couponTypes[0]) {
    if (coupon.applyTo == applyTos[0]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Money Back Offer🤑",
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    coupon.couponName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: Text(couponDetails(coupon: coupon)),
            ),
          ),
        ],
      );
    } else if (coupon.applyTo == applyTos[1]) {
      ProductModel product = ref
          .watch(productControllerProvider)
          .getProductByName(coupon.productName!)
          .first as ProductModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Money Back Offer🤑"),
          Text("${coupon.discountAmount} ৳ Off for"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: hProductCard(
                  context: context,
                  product: product,
                  discountAmount: coupon.discountAmount),
            ),
          )
        ],
      );
    } else if (coupon.applyTo == applyTos[2]) {
      List<ProductModel> products = ref
          .watch(productControllerProvider)
          .getProductsByCategoryName(coupon.categoryName!)
          .first as List<ProductModel>;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Money Back Offer🤑"),
          Text("${coupon.discountAmount} ৳ Off for"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: ListView.builder(
                itemBuilder: (context, index) => productCard(
                    imageURL: products[index].productImageUrls.first,
                    productName: products[index].productName),
              ),
            ),
          )
        ],
      );
    }
  } else if (coupon.couponType == couponTypes[1]) {
    if (coupon.applyTo == applyTos[0]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Money Back Offer🤑"),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: Text(couponDetails(coupon: coupon)),
            ),
          ),
        ],
      );
    } else if (coupon.applyTo == applyTos[1]) {
      ProductModel product = ref
          .watch(productControllerProvider)
          .getProductByName(coupon.productName!)
          .first as ProductModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Money Back Offer🤑"),
          Text("${coupon.discountPercent} % Off for"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: hProductCard(
                  context: context,
                  product: product,
                  discountPercentage: coupon.discountPercent),
            ),
          )
        ],
      );
    } else if (coupon.applyTo == applyTos[2]) {
      List<ProductModel> products = ref
          .watch(productControllerProvider)
          .getProductsByCategoryName(coupon.categoryName!)
          .first as List<ProductModel>;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Money Back Offer🤑"),
          Text("${coupon.discountAmount} % Off for"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: ListView.builder(
                itemBuilder: (context, index) => productCard(
                    imageURL: products[index].productImageUrls.first,
                    productName: products[index].productName),
              ),
            ),
          )
        ],
      );
    }
  } else if (coupon.couponType == couponTypes[2]) {
    if (coupon.applyTo == applyTos[3]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Free Shipping🚚"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: Text(couponDetails(coupon: coupon)),
            ),
          ),
        ],
      );
    } else if (coupon.applyTo == applyTos[4]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Free Shipping🚚"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: Text(couponDetails(coupon: coupon)),
            ),
          ),
        ],
      );
    }
  } else if (coupon.couponType == couponTypes[3]) {
    if (coupon.applyTo == applyTos[0]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Flat Rate Offer😲"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
                title: Row(
                  children: [
                    Text(coupon.couponName),
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: coupon.couponCode));
                      },
                      icon: const Icon(Icons.copy),
                      label: Text(coupon.couponCode),
                    ),
                  ],
                ),
                subtitle: Text(couponDetails(coupon: coupon))),
          )
        ],
      );
    } else if (coupon.applyTo == applyTos[1]) {
      ProductModel product = ref
          .watch(productControllerProvider)
          .getProductByName(coupon.productName!)
          .first as ProductModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Flat Rate Offer😲"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: hProductCard(
                context: context,
                product: product,
                salePrice: coupon.salePrice,
              ),
            ),
          )
        ],
      );
    } else if (coupon.applyTo == applyTos[2]) {
      List<ProductModel> products = ref
          .watch(productControllerProvider)
          .getProductsByCategoryName(coupon.categoryName!)
          .first as List<ProductModel>;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Flat Rate Offer😲"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: ListView.builder(
                itemBuilder: (context, index) => productCard(
                    imageURL: products[index].productImageUrls.first,
                    productName: products[index].productName),
              ),
            ),
          ),
        ],
      );
      // "All Products of ${coupon.categoryName} at ${coupon.salePrice}৳";
    }
  } else {
    if (coupon.applyTo == applyTos[0]) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Buy ${coupon.buyQuantity} get ${coupon.getQuantity} Offer"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: Text(
                couponDetails(coupon: coupon),
              ),
            ),
          ),
        ],
      );
    } else if (coupon.applyTo == applyTos[1]) {
      ProductModel product = ref
          .watch(productControllerProvider)
          .getProductByName(coupon.productName!)
          .first as ProductModel;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Buy ${coupon.buyQuantity} get ${coupon.getQuantity} Offer"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: hProductCard(context: context, product: product),
            ),
          )
        ],
      );
    } else if (coupon.applyTo == applyTos[2]) {
      List<ProductModel> products = ref
          .watch(productControllerProvider)
          .getProductsByCategoryName(coupon.categoryName!)
          .first as List<ProductModel>;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Buy ${coupon.buyQuantity} get ${coupon.getQuantity} Offer"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              title: Row(
                children: [
                  Text(coupon.couponName),
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: coupon.couponCode));
                    },
                    icon: const Icon(Icons.copy),
                    label: Text(coupon.couponCode),
                  ),
                ],
              ),
              subtitle: ListView.builder(
                itemBuilder: (context, index) => productCard(
                    imageURL: products[index].productImageUrls.first,
                    productName: products[index].productName),
              ),
            ),
          )
        ],
      );
    }
  }
  return Container();
}
