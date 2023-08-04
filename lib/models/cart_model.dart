import 'package:isar/isar.dart';
part 'cart_model.g.dart';

@Collection()
class CartModel {
  Id cartID = Isar.autoIncrement;
  late String productID;
  late int quantity;
  late int totalExpense;
  late String color;
  late String size;
}
