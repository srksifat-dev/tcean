import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/features/account/screens/account_screen.dart';
import 'package:tcean/features/cart/screens/cart_screen.dart';
import 'package:tcean/features/checkout/screens/checkout_screen.dart';
import 'package:tcean/features/customize/screens/customize_screen.dart';
import 'package:tcean/features/explore/screens/explore_screen.dart';
import 'package:tcean/features/explore/screens/offer_screen.dart';
import 'package:tcean/features/favorite/screens/favorites_screen.dart';
import 'package:tcean/features/notification/screens/notification_screen.dart';
import 'package:tcean/features/order_tracking/screens/order_screen.dart';
import 'package:tcean/features/order_tracking/screens/order_screen_details.dart';
import 'package:tcean/features/store/screens/store_screen.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/auth/screens/otp_screen.dart';
import '../features/store/screens/product_details_screen.dart';
import '../main_screen.dart';
import 'route_const.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: "/explore",
    navigatorKey: rootNavigatorKey,
    redirect: (context, state) {
      final loggedIn = loginInfo.isLoggedIn;
      final isLoggingIn = state.location == "/${RouteConst.kAuth}";

      if (!loggedIn && !isLoggingIn) return "/${RouteConst.kAuth}";
      if (loggedIn && isLoggingIn) return "/explore";

      return null;
    },
    refreshListenable: loginInfo,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return CupertinoPage(child: MainScreen(child: child));
        },
        routes: [
          GoRoute(
            path: "/explore",
            parentNavigatorKey: shellNavigatorKey,
            name: RouteConst.kExploreScreen,
            pageBuilder: (context, state) => CupertinoPage(
              child: ExploreScreen(),
            ),
            routes: [
              GoRoute(
                path: "customize",
                parentNavigatorKey: rootNavigatorKey,
                name: RouteConst.kCustomize,
                pageBuilder: (context, state) => CupertinoPage(
                  child: CustomizeScreen(),
                ),
              ),
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: RouteConst.kOffer,
                path: ":offerID",
                pageBuilder: (context, state) {
                  return CupertinoPage(
                    key: state.pageKey,
                    child: OfferScreen(
                      offerID: state.pathParameters["offerID"]!,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            name: RouteConst.kStore,
            path: "/store",
            pageBuilder: (context, state) {
              return CupertinoPage(
                key: state.pageKey,
                child: StoreScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: rootNavigatorKey,
                name: RouteConst.kProductDetails,
                path: ":productID",
                pageBuilder: (context, state) {
                  return CupertinoPage(
                    key: state.pageKey,
                    child: ProductDetailsScreen(
                      productID: state.pathParameters["productID"]!,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: "/favorites",
            parentNavigatorKey: shellNavigatorKey,
            name: RouteConst.kFavorites,
            pageBuilder: (context, state) => CupertinoPage(
              child: FavoritesScreen(),
            ),
          ),
          GoRoute(
            path: "/cart",
            parentNavigatorKey: shellNavigatorKey,
            name: RouteConst.kCart,
            pageBuilder: (context, state) => CupertinoPage(
              child: CartScreen(),
            ),
            routes: [
              GoRoute(
                path: "checkout",
                parentNavigatorKey: rootNavigatorKey,
                name: RouteConst.kCheckout,
                pageBuilder: (context, state) => CupertinoPage(
                  child: CheckoutScreen(),
                ),
              ),
            ]
          ),
          GoRoute(
            path: "/account",
            parentNavigatorKey: shellNavigatorKey,
            name: RouteConst.kAccount,
            pageBuilder: (context, state) => CupertinoPage(
              child: AccountScreen(),
            ),
            routes: [
              GoRoute(
                path: RouteConst.kOrders,
                parentNavigatorKey: rootNavigatorKey,
                name: RouteConst.kOrders,
                pageBuilder: (context, state) =>
                    CupertinoPage(child: OrderScreen()),
                routes: [
                  GoRoute(
                    path: ":orderID",
                    name: RouteConst.kOrderDetails,
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) => CupertinoPage(
                      child: OrderDetailsScreen(
                        orderID: state.pathParameters["orderID"]!,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/notifications",
        name: RouteConst.kNotifications,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => CupertinoPage(
          child: NotificationScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        name: RouteConst.kAuth,
        path: "/auth",
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: AuthScreen(),
        ),
        routes: [
          GoRoute(
            name: RouteConst.kOtp,
            path: "otp",
            pageBuilder: (context, state) => CupertinoPage(
              key: state.pageKey,
              child: OtpScreen(""),
            ),
          ),
        ],
      ),
    ],
  );
}
