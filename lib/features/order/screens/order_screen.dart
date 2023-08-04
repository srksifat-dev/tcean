import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/features/order/controller/order_controller.dart';
import 'package:tcean/main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/constants/route_const.dart';
import '../widgets/order_card.dart';

class OrderScreen extends ConsumerWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: ref.watch(getOrdersProvider(userModel!.uid)).when(data: (orders) => ListView.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final reverseOrderList = orders.reversed.toList();
          return InkWell(
              onTap: () {
                context.pushNamed(RouteConst.kOrderDetails,
                    pathParameters: {"orderID": reverseOrderList[index].orderID});
              },
              child: orderCard(context: context, order: reverseOrderList[index]));
        },
        separatorBuilder: (_, __) => 8.heightBox,
      ).px(16),error: (error, stackTrace) => ErrorText(error: error.toString()),loading: () => const Loader(),),
      
    );
  }
}
