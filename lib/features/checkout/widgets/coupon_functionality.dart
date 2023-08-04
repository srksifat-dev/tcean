// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tcean/core/common/error_text.dart';
// import 'package:tcean/core/common/loader.dart';
// import 'package:tcean/features/explore/controller/offer_controller.dart';
// import 'package:tcean/models/cart_model.dart';
// import 'package:tcean/models/coupon_model.dart';
// import 'package:tcean/models/product_model.dart';

// import '../screens/checkout_screen.dart';

// void afterCouponApplied(
//     {required CartModel cartModel,
//     required String couponCode,
//     required int totalOrderExpense,
//     required int quantity,
//     required WidgetRef ref}) {
//   ref.watch(getOffersProvider).when(
//       data: (coupons) {
//         if (coupons != null) {
//           for (CouponModel coupon in coupons) {
//             // Verify Coupon code
//             print("Coupon verified");
//             if (coupon.couponCode == couponCode) {
//               switch (coupon.couponType) {
//                 case "moneyDiscount":
//                   switch (coupon.applyTo) {
//                     case "All Products":
//                       //Do something
//                       print("Money Discount");
//                       discountedTotalExpense =
//                           cartModel.totalExpense - (coupon.discountAmount! * quantity);
//                       break;
//                     case "Specific Product":
//                       //Do Something
//                       var p = products
//                           .where((element) =>
//                               element.productName == coupon.productName)
//                           .first;
//                       if (cartModel.productID == p.productID) {
//                         discountedTotalExpense =
//                             cartModel.totalExpense - (coupon.discountAmount! * quantity);
//                       }
//                       break;
//                     case "Specific Category":
//                       //DO Something

//                       break;
//                     case "Minimum Order Subtotal":
//                       //Do Something
//                       if (totalOrderExpense >= coupon.minimumOrder!) {
//                         discountedTotalExpense =
//                             cartModel.totalExpense - (coupon.discountAmount! * quantity);
//                       }

//                       break;
//                   }
//                   break;
//                 case "percentDiscount":
//                   switch (coupon.applyTo) {
//                     case "All Products":
//                       //Do Something
//                       discountedTotalExpense = cartModel.totalExpense -
//                           (cartModel.totalExpense *
//                                   (coupon.discountPercent! / 100))
//                               .toInt();
//                       break;
//                     case "Specific Product":
//                       //Do something
//                       var p = products
//                           .where((element) =>
//                               element.productName == coupon.productName)
//                           .first;
//                       if (cartModel.productID == p.productID) {
//                         discountedTotalExpense = cartModel.totalExpense -
//                             (cartModel.totalExpense *
//                                     (coupon.discountPercent! / 100))
//                                 .toInt();
//                       }
//                       break;
//                     case "Specific Category":
//                       //Do Something
//                       break;
//                     case "Minimum Order Subtotal":
//                       //DO SOmething
//                       if (totalOrderExpense >= coupon.minimumOrder!) {
//                         discountedTotalExpense = cartModel.totalExpense -
//                             (cartModel.totalExpense *
//                                     (coupon.discountPercent! / 100))
//                                 .toInt();
//                       }
//                       break;
//                   }
//                   break;
//                 case "freeShipping":
//                   switch (coupon.applyTo) {
//                     case "All Orders":
//                       //DO something
//                       discountedDeliveryCharge = 0;
//                       break;
//                     case "Minimum Order Subtotal":
//                       //Do Something
//                       if (totalOrderExpense >= coupon.minimumOrder!) {
//                         discountedDeliveryCharge = 0;
//                       }
//                       break;
//                   }
//                   break;
//                 case "salePrice":
//                   switch (coupon.applyTo) {
//                     case "All Products":
//                       //Do Something
//                       discountedTotalExpense =
//                           coupon.salePrice! * cartModel.quantity;
//                       break;
//                     case "Specific Product":
//                       //Do Something
//                       var p = products
//                           .where((element) =>
//                               element.productName == coupon.productName)
//                           .first;
//                       if (cartModel.productID == p.productID) {
//                         discountedTotalExpense =
//                             (coupon.salePrice! * cartModel.quantity);
//                       }
//                       break;
//                     case "Specific Category":
//                       //Do Something
//                       break;
//                   }
//                   break;
//                 case "buyXGetYFree":
//                   switch (coupon.applyTo) {
//                     case "All Products":
//                       //Do SOmething
//                       if (cartModel.quantity >= coupon.buyQuantity!) {
//                         discountedQuantity =
//                             cartModel.quantity + coupon.getQuantity!;
//                       }
//                       break;
//                     case "Specific Product":
//                       //Do SOmething
//                       var p = products
//                           .where((element) =>
//                               element.productName == coupon.productName)
//                           .first;
//                       if (cartModel.productID == p.productID) {
//                         if (cartModel.quantity >= coupon.buyQuantity!) {
//                           discountedQuantity =
//                               cartModel.quantity + coupon.getQuantity!;
//                         }
//                       }
//                       break;
//                     case "Specific Category":
//                       //Do Something
//                       break;
//                   }
//                   break;
//                 default:
//               }
//             }
//           }
//         } else {
//           return 0;
//         }
//       },
//       error: (error, stackTrace) => ErrorText(error: error.toString()),
//       loading: () => Loader());
// }
