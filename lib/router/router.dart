import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/features/user/screens/withdraw_screen.dart';
import 'package:tcean/models/order_model.dart';

import '../core/constants/route_const.dart';
import '../features/auth/screens/auth_screen.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/checkout/screens/checkout_screen.dart';
import '../features/customize_order/screens/customize_screen.dart';
import '../features/explore/screens/explore_screen.dart';
import '../features/explore/screens/offer_screen.dart';
import '../features/notification/screens/notification_screen.dart';
import '../features/order/screens/order_screen.dart';
import '../features/order/screens/order_screen_details.dart';
import '../features/payment/screens/payment_screen.dart';
import '../features/products/screens/product_details_screen.dart';
import '../features/products/screens/products_screen.dart';
import '../features/user/screens/user_screen.dart';
import '../main_screen.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

List<RouteBase> routes = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        MainScreen(key: state.pageKey, child: navigationShell),
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: "/",
          name: RouteConst.kExplore,
          pageBuilder: (context, state) => CupertinoPage(
            child: ExploreScreen(),
          ),
          routes: [
            GoRoute(
              path: "customize",
              name: RouteConst.kCustomize,
              pageBuilder: (context, state) => const CupertinoPage(
                child: CustomizeOrderScreen(),
              ),
            ),
            GoRoute(
              name: RouteConst.kOffer,
              path: RouteConst.kOffer,
              pageBuilder: (context, state) {
                return CupertinoPage(
                  key: state.pageKey,
                  child: const OfferScreen(),
                );
              },
            ),
          ],
        ),
      ]),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: RouteConst.kStore,
            path: "/${RouteConst.kStore}",
            pageBuilder: (context, state) {
              return CupertinoPage(
                key: state.pageKey,
                child: const ProductsScreen(),
              );
            },
            routes: [
              GoRoute(
                name: RouteConst.kProductDetails,
                path: ":productID",
                pageBuilder: (context, state) {
                  return CupertinoPage(
                    key: state.pageKey,
                    child: ProductDetailsScreen(
                      productID: state.pathParameters["productID"]!,
                      product: state.extra as ProductModel,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      //TODO: Favorite screen
      // StatefulShellBranch(
      //   routes: [
      //     GoRoute(
      //       path: "/${RouteConst.kFavorites}",
      //       name: RouteConst.kFavorites,
      //       pageBuilder: (context, state) => CupertinoPage(
      //         child: FavoritesScreen(),
      //       ),
      //     ),
      //   ],
      // ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/${RouteConst.kCart}",
            name: RouteConst.kCart,
            pageBuilder: (context, state) => const CupertinoPage(
              child: CartScreen(),
            ),
            routes: [
              GoRoute(
                path: RouteConst.kCheckout,
                name: RouteConst.kCheckout,
                pageBuilder: (context, state) => CupertinoPage(
                  child: CheckoutScreen(
                    carts: state.extra as List<CartModel>,
                  ),
                ),
                routes: [
                  GoRoute(
                    path: RouteConst.kPayment,
                    name: RouteConst.kPayment,
                    pageBuilder: (context, state) => const CupertinoPage(
                      child: PaymentScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(routes: [
        GoRoute(
          path: "/${RouteConst.kUser}",
          name: RouteConst.kUser,
          pageBuilder: (context, state) => const CupertinoPage(
            child: UserScreen(),
          ),
          routes: [
            GoRoute(
              path: RouteConst.kOrders,
              name: RouteConst.kOrders,
              pageBuilder: (context, state) =>
                  CupertinoPage(child: OrderScreen()),
              routes: [
                GoRoute(
                  path: ":orderID",
                  name: RouteConst.kOrderDetails,
                  pageBuilder: (context, state) => CupertinoPage(
                    child: OrderDetailsScreen(
                      orderID: state.pathParameters["orderID"]!,
                      order: state.extra as OrderModel,
                    ),
                  ),
                ),
              ],
            ),
            GoRoute(path: RouteConst.kWithdraw,
            name: RouteConst.kWithdraw,
            pageBuilder: (context,state)=>CupertinoPage(child: WithdrawScreen()))
          ],
        ),
      ])
    ],
  ),
  GoRoute(
    path: "/${RouteConst.kNotifications}",
    name: RouteConst.kNotifications,
    pageBuilder: (context, state) => const CupertinoPage(
      child: NotificationScreen(),
    ),
  ),
  GoRoute(
    name: RouteConst.kAuth,
    path: "/${RouteConst.kAuth}",
    pageBuilder: (context, state) => CupertinoPage(
      key: state.pageKey,
      child: const AuthScreen(),
    ),
  ),
];
