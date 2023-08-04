
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/features/cart/controller/cart_controller.dart';


class MainScreen extends ConsumerWidget {
  final StatefulNavigationShell child;
  MainScreen({Key? key, required this.child}) : super(key: key);

  void onTap(int index) {
    child.goBranch(index, initialLocation: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(icon: Icon(Icons.sell), label: "Explore"),
          const NavigationDestination(icon: Icon(Icons.storefront), label: "Store"),
          //TODO: Implement Favorite Screen
          // NavigationDestination(icon: Icon(Icons.favorite), label: "Favorites"),
          ref.watch(getCartsProvider).when(
                data: (data) => NavigationDestination(
                    icon: Badge(
                        label: AnimatedFlipCounter(value: data.length),
                        child: const Icon(Icons.shopping_bag)),
                    label: "Cart"),
                error: (error, stackTrace) => NavigationDestination(
                    icon:
                        Badge.count(count: 0, child: const Icon(Icons.shopping_bag)),
                    label: "Cart"),
                loading: () => NavigationDestination(
                    icon:
                        Badge.count(count: 0, child: const Icon(Icons.shopping_bag)),
                    label: "Cart"),
              ),
          const NavigationDestination(icon: Icon(Icons.person), label: "Account"),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: const Duration(milliseconds: 1000),
        selectedIndex: child.currentIndex,
        onDestinationSelected: onTap,
      ),
      body: child,
    );
  }
}
