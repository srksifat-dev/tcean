import '../models/cart.dart';
import 'dummy_product.dart';

List<Cart> carts = [
  Cart(
      product: dummyProducts[0],
      quantity: 1,
      color: "white",
      size: "m",
      totalExpense: 300),
  Cart(
      product: dummyProducts[1],
      quantity: 2,
      color: "black",
      size: "l",
      totalExpense: 300),
  Cart(
      product: dummyProducts[2],
      quantity: 3,
      color: "white",
      size: "xl",
      totalExpense: 300),
  Cart(
      product: dummyProducts[3],
      quantity: 4,
      color: "black",
      size: "xxl",
      totalExpense: 300),
  Cart(
      product: dummyProducts[4],
      quantity: 5,
      color: "white",
      size: "xxxl",
      totalExpense: 300),
];
