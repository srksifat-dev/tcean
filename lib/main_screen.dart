import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcean/features/account/screens/account_screen.dart';
import 'package:tcean/features/cart/screens/cart_screen.dart';
import 'package:tcean/features/favorite/screens/favorites_screen.dart';
import 'package:tcean/features/home/screens/home_screen.dart';
import 'package:tcean/features/shop/screens/shop_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int bottomNavigationIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    ShopScreen(),
    FavoritesScreen(),
    CartScreen(),
    AccountScreen(),
  ];
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
              "tcean",
              style: GoogleFonts.josefinSans()
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 40),
            )
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
        selectedIndex: bottomNavigationIndex,
        onDestinationSelected: (value) {
          setState(() {
            bottomNavigationIndex = value;
          });
        },
      ),
      body: pages[bottomNavigationIndex],
    );
  }
}
