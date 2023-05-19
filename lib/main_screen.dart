import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomNavigationIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    switch (location) {
      case "/explore":
        return 0;
      case "/store":
        return 1;
      case "/favorites":
        return 2;
      case "/cart":
        return 3;
      case "/account":
        return 4;
      default:
        return 0;
    }
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go("/explore");
      case 1:
        return context.go("/store");
      case 2:
        return context.go("/favorites");
      case 3:
        return context.go("/cart");
      case 4:
        return context.go("/account");
      default:
        return context.go("/explore");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Image.asset(
              "assets/images/tcean-logo.png",
              height: 30,
            ),
            4.widthBox,
            Text(
              "tce",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Text(
                "e",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              "n",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.sell), label: "Explore"),
          NavigationDestination(icon: Icon(Icons.storefront), label: "Store"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
          NavigationDestination(icon: Icon(Icons.shopping_bag), label: "Cart"),
          NavigationDestination(icon: Icon(Icons.person), label: "Account"),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: Duration(milliseconds: 1000),
        selectedIndex: bottomNavigationIndex(context),
        onDestinationSelected: onTap,
      ),
      body: widget.child,
    );
  }
}
