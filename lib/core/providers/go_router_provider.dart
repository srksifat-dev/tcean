// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tcean/features/auth/controller/auth_controller.dart';
// import 'package:tcean/features/user/screens/user_screen.dart';
// import 'package:tcean/models/cart.dart';
// import 'package:tcean/models/product_model.dart';

// import '../../features/auth/screens/auth_screen.dart';
// import '../../features/cart/screens/cart_screen.dart';
// import '../../features/checkout/screens/checkout_screen.dart';
// import '../../features/customize_order/screens/customize_screen.dart';
// import '../../features/explore/screens/explore_screen.dart';
// import '../../features/explore/screens/offer_screen.dart';
// import '../../features/notification/screens/notification_screen.dart';
// import '../../features/order/screens/order_screen.dart';
// import '../../features/order_tracking/screens/order_screen_details.dart';
// import '../../features/payment/screens/payment_screen.dart';
// import '../../features/products/screens/product_details_screen.dart';
// import '../../features/products/screens/products_screen.dart';
// import '../../main_screen.dart';
// import '../../models/user.dart';
// import '../constants/route_const.dart';

// final goRouterProvider = Provider.family<GoRouter, User?>((ref, user) {
//   final router = RouterNotifier(ref: ref);
//   return GoRouter(
//     refreshListenable: router,
//     routes: router._routes,
//     redirect: (context, state) => router._redirectLogic(state, user),
//     initialLocation: "/${RouteConst.kExplore}",
//   );
// });

// class RouterNotifier extends ChangeNotifier {
//   final Ref _ref;

//   RouterNotifier({required Ref ref}) : _ref = ref;

//   String? _redirectLogic(GoRouterState state, User? user) {
//     final loginState = _ref.watch(authStateChangeProvider);

//     final isInCheckoutScreen =
//         state.uri.toString() == "/${RouteConst.kCart}/${RouteConst.kCheckout}";

//     UserModel? userModel;

//     void getData(Ref ref, user) async {
//       userModel = await ref
//           .watch(authControllerProvider.notifier)
//           .getUserData(user.uid)
//           .first;

//       ref.read(userProvider.notifier).update((state) => userModel);
//     }

//     bool loggedIn = false;
//     if (user != null) {
//       getData(_ref, user);
//       if (userModel != null) {
//         loggedIn = true;
//       }
//     } else {
//       loggedIn = false;
//     }
//     final isLoggingIn = state.uri.toString() == "/${RouteConst.kAuth}";

//     if (!loggedIn && !isLoggingIn) return "/${RouteConst.kAuth}";
//     if (loggedIn) return "/${RouteConst.kExplore}";

//     return null;
//     // if (loggedIn && isLoggingIn) return "/explore";
//   }

//   List<RouteBase> get _routes => [
//         StatefulShellRoute.indexedStack(
//           builder: (context, state, navigationShell) =>
//               MainScreen(key: state.pageKey, child: navigationShell),
//           branches: [
//             StatefulShellBranch(routes: [
//               GoRoute(
//                 path: "/${RouteConst.kExplore}",
//                 name: RouteConst.kExplore,
//                 pageBuilder: (context, state) => CupertinoPage(
//                   child: ExploreScreen(),
//                 ),
//                 routes: [
//                   GoRoute(
//                     path: "customize",
//                     name: RouteConst.kCustomize,
//                     pageBuilder: (context, state) => CupertinoPage(
//                       child: CustomizeOrderScreen(),
//                     ),
//                   ),
//                   GoRoute(
//                     name: RouteConst.kOffer,
//                     path: ":offerID",
//                     pageBuilder: (context, state) {
//                       return CupertinoPage(
//                         key: state.pageKey,
//                         child: OfferScreen(
//                           offerID: state.pathParameters["offerID"]!,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ]),
//             StatefulShellBranch(
//               routes: [
//                 GoRoute(
//                   name: RouteConst.kStore,
//                   path: "/${RouteConst.kStore}",
//                   pageBuilder: (context, state) {
//                     return CupertinoPage(
//                       key: state.pageKey,
//                       child: StoreScreen(),
//                     );
//                   },
//                   routes: [
//                     GoRoute(
//                       name: RouteConst.kProductDetails,
//                       path: ":productID",
//                       pageBuilder: (context, state) {
//                         return CupertinoPage(
//                           key: state.pageKey,
//                           child: ProductDetailsScreen(
//                             productID: state.pathParameters["productID"]!,
//                             product: state.extra as ProductModel,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             //TODO: Favorite screen
//             // StatefulShellBranch(
//             //   routes: [
//             //     GoRoute(
//             //       path: "/${RouteConst.kFavorites}",
//             //       name: RouteConst.kFavorites,
//             //       pageBuilder: (context, state) => CupertinoPage(
//             //         child: FavoritesScreen(),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             StatefulShellBranch(
//               routes: [
//                 GoRoute(
//                   path: "/${RouteConst.kCart}",
//                   name: RouteConst.kCart,
//                   pageBuilder: (context, state) => CupertinoPage(
//                     child: CartScreen(),
//                   ),
//                   routes: [
//                     GoRoute(
//                       path: RouteConst.kCheckout,
//                       name: RouteConst.kCheckout,
//                       pageBuilder: (context, state) => CupertinoPage(
//                         child: CheckoutScreen(
//                           carts: state.extra as List<Cart>,
//                         ),
//                       ),
//                       routes: [
//                         GoRoute(
//                           path: RouteConst.kPayment,
//                           name: RouteConst.kPayment,
//                           pageBuilder: (context, state) => CupertinoPage(
//                             child: PaymentScreen(),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             StatefulShellBranch(routes: [
//               GoRoute(
//                 path: "/${RouteConst.kUser}",
//                 name: RouteConst.kUser,
//                 pageBuilder: (context, state) => CupertinoPage(
//                   child: UserScreen(),
//                 ),
//                 routes: [
//                   GoRoute(
//                     path: "${RouteConst.kOrders}",
//                     name: RouteConst.kOrders,
//                     pageBuilder: (context, state) =>
//                         CupertinoPage(child: OrderScreen()),
//                     routes: [
//                       GoRoute(
//                         path: ":orderID",
//                         name: RouteConst.kOrderDetails,
//                         pageBuilder: (context, state) => CupertinoPage(
//                           child: OrderDetailsScreen(
//                             orderID: state.pathParameters["orderID"]!,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ])
//           ],
//         ),
//         GoRoute(
//           path: "/${RouteConst.kNotifications}",
//           name: RouteConst.kNotifications,
//           pageBuilder: (context, state) => CupertinoPage(
//             child: NotificationScreen(),
//           ),
//         ),
//         GoRoute(
//           name: RouteConst.kAuth,
//           path: "/${RouteConst.kAuth}",
//           pageBuilder: (context, state) => CupertinoPage(
//             key: state.pageKey,
//             child: AuthScreen(),
//           ),
//         ),
//       ];
// }
