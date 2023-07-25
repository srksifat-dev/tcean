import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/main_appBar.dart';
import 'package:tcean/dummy/dummy_product.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dummy/dummy_cart.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell child;
  MainScreen({Key? key, required this.child}) : super(key: key);

  void onTap(int index) {
    child.goBranch(index);
  }

  bool _isBackPressed = false;

  Future<bool> _onWillPop() async {
    if (_isBackPressed) {
      // If already pressed once, exit the app
      return true;
    }

    _isBackPressed = true;
    _showSnackBar('Press back again to exit');

    Timer(const Duration(seconds: 2), () {
      // Reset the flag after 2 seconds
      _isBackPressed = false;
    });

    return false;
  }

  void _showSnackBar(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.sell), label: "Explore"),
            NavigationDestination(icon: Icon(Icons.storefront), label: "Store"),
            //TODO: Implement Favorite Screen
            // NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
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
      ),
    );
  }
}
