import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/dummy/dummy_order.dart';
import 'package:tcean/features/order_tracking/widgets/order_card.dart';
import 'package:tcean/features/order_tracking/widgets/order_item_card.dart';
import 'package:tcean/models/order.dart';
import 'package:tcean/routes/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> orders = dummyOrders;
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your order"),
      ),
      body: ListView.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final reverseOrderList = orders.reversed;
          return InkWell(
              onTap: () {
                context.pushNamed(RouteConst.kOrderDetails,
                    pathParameters: {"orderID": orders[index].orderID});
              },
              child: orderCard(context: context, order: orders[index]));
        },
        separatorBuilder: (_, __) => 8.heightBox,
      ).px(16),
    );
  }
}
