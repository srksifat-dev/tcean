import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/routes/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/editable_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          editableCard(
              context: context,
              title: "My Name",
              icon: Icons.edit,
              onTap: () {}),
          editableCard(
              context: context,
              title: "Phone Number",
              icon: Icons.phone,
              onTap: () {}),
          editableCard(
              context: context,
              title: "My Balance",
              subtitle: Text("৳300.00",style: Theme.of(context).textTheme.bodyMedium,),
              icon: Icons.download,
              onTap: () {}),
          editableCard(
              context: context,
              title: "Addresses",
              subtitle: Text("Road No., Area, District",style: Theme.of(context).textTheme.bodyMedium,),
              icon: Icons.location_city,
              onTap: () {}),
          editableCard(
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
