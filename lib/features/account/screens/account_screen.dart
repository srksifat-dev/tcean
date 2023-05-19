import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/routes/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/account_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          accountCard(
              context: context,
              title: "My Name",
              icon: Icons.edit,
              onTap: () {}),
          accountCard(
              context: context,
              title: "Phone Number",
              icon: Icons.phone,
              onTap: () {}),
          accountCard(
              context: context,
              title: "My Balance",
              subtitle: "৳300.00",
              icon: Icons.download,
              onTap: () {}),
          accountCard(
              context: context,
              title: "Addresses",
              subtitle: "Road No., Area, District",
              icon: Icons.location_city,
              onTap: () {}),
          accountCard(
              context: context,
              title: "Orders",
              icon: Icons.shopping_bag,
              onTap: () {
                context.pushNamed(RouteConst.kOrders);
              }),
        ],
      ).px(16),
    );
  }
}
