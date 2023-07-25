import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dummy/dummy_cart.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell child;
  const MainScreen({Key? key, required this.child}) : super(key: key);

  void onTap(int index) {
    child.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.sell), label: "Explore"),
          NavigationDestination(icon: Icon(Icons.storefront), label: "Store"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
          NavigationDestination(
              icon: Badge.count(
                  count: carts.length, child: Icon(Icons.shopping_bag)),
              label: "Cart"),
          NavigationDestination(icon: Icon(Icons.person), label: "Account"),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: Duration(milliseconds: 1000),
        selectedIndex: child.currentIndex,
        onDestinationSelected: onTap,
      ),
      body: child,
    );
  }
}
