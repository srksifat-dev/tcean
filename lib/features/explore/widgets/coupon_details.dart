import 'package:flutter/material.dart';
import 'package:tcean/models/coupon_model.dart';

String couponDetails({required CouponModel coupon}) {
  if (coupon.couponType == couponTypes[0]) {
    if (coupon.applyTo == applyTos[0]) {
      return "${coupon.discountAmount} ৳ Off for All Products";
    } else if (coupon.applyTo == applyTos[1]) {
      return "${coupon.discountAmount} ৳ Off for ${coupon.productName}";
    } else if (coupon.applyTo == applyTos[2]) {
      return "${coupon.discountAmount} ৳ Off for ${coupon.categoryName}";
    } else if (coupon.applyTo == applyTos[4]) {
      return "${coupon.discountAmount} ৳ Off on orders over ${coupon.minimumOrder.toString()} ৳";
    }
  } else if (coupon.couponType == couponTypes[1]) {
    if (coupon.applyTo == applyTos[0]) {
      return "${coupon.discountPercent} % Off for All Products";
    } else if (coupon.applyTo == applyTos[1]) {
      return "${coupon.discountPercent} % Off for ${coupon.productName}";
    } else if (coupon.applyTo == applyTos[2]) {
      return "${coupon.discountPercent} % Off for ${coupon.categoryName}";
    } else if (coupon.applyTo == applyTos[4]) {
      return "${coupon.discountPercent} % Off on orders over ${coupon.minimumOrder.toString()} ৳";
    }
  } else if (coupon.couponType == couponTypes[2]) {
    if (coupon.applyTo == applyTos[3]) {
      return "Free Shipping on All Orders";
    } else if (coupon.applyTo == applyTos[4]) {
      return "Free Shipping on orders over ${coupon.minimumOrder.toString()} ৳";
    }
  } else if (coupon.couponType == couponTypes[3]) {
    if (coupon.applyTo == applyTos[0]) {
      return "All Products at ${coupon.salePrice}৳";
    } else if (coupon.applyTo == applyTos[1]) {
      return "${coupon.productName} at ${coupon.salePrice}৳";
    } else if (coupon.applyTo == applyTos[2]) {
      return "All Products of ${coupon.categoryName} at ${coupon.salePrice}৳";
    }
  } else {
    if (coupon.applyTo == applyTos[0]) {
      return "Buy ${coupon.buyQuantity} get ${coupon.getQuantity} free";
    } else if (coupon.applyTo == applyTos[1]) {
      return "Buy ${coupon.buyQuantity} get ${coupon.getQuantity} free for ${coupon.productName}";
    } else if (coupon.applyTo == applyTos[2]) {
      return "Buy ${coupon.buyQuantity} get ${coupon.getQuantity} free for ${coupon.categoryName}";
    }
  }
  return "";
}

IconData couponIcon(CouponModel coupon) {
  if (coupon.couponType == couponTypes[0]) {
    return Icons.attach_money;
  } else if (coupon.couponType == couponTypes[1]) {
    return Icons.percent;
  } else if (coupon.couponType == couponTypes[2]) {
    return Icons.local_shipping;
  } else if (coupon.couponType == couponTypes[3]) {
    return Icons.sell;
  } else if (coupon.couponType == couponTypes[4]) {
    return Icons.plus_one;
  }
  return Icons.loyalty;
}


