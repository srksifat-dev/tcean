import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import 'route_const.dart';

class AppRouter {
  GoRouter router = GoRouter(
      // redirect: (context, state) {
      //   final loggedIn = loginInfo.isLoggedIn;
      //   final isLoggingIn = state.location == "/${RouteConst.kAuth}";

      //   if (!loggedIn && !isLoggingIn) return "/${RouteConst.kAuth}";
      //   if (loggedIn && isLoggingIn) return "/";

      //   return null;
      // },
      // refreshListenable: loginInfo,
      routes: [
        // GoRoute(
        //     name: RouteConst.kHomeScreen,
        //     path: "/",
        //     pageBuilder: (context, state) => CupertinoPage(
        //           key: state.pageKey,
        //             child: MainScreen(),
        //         ),
        //     routes: [
              // GoRoute(
              //   name: RouteConst.kCart,
              //   path: "cart",
              //   pageBuilder: (context, state) => CupertinoPage(
              //     key: state.pageKey,
              //     child: CartScreen(),
              //   ),
              // ),
              // GoRoute(
              //   name: RouteConst.kAccount,
              //   path: "Account",
              //   pageBuilder: (context, state) => CupertinoPage(
              //     key: state.pageKey,
              //     child: AccountScreen(),
              //   ),
              // ),
              // GoRoute(
              //   name: RouteConst.kCustomize,
              //   path: "customize",
              //   pageBuilder: (context, state) {
              //     return CupertinoPage(
              //         key: state.pageKey, child: CustomizedScreen());
              //   },
              // ),
              // GoRoute(
              //     name: RouteConst.kProducts,
              //     path: "products",
              //     pageBuilder: (context, state) {
              //       return CupertinoPage(
              //           key: state.pageKey, child: ProductScreen());
              //     },
              //     routes: [
              //       GoRoute(
              //         name: RouteConst.kProductDetails,
              //         path: ":productID",
              //         pageBuilder: (context, state) {
              //           return CupertinoPage(
              //               key: state.pageKey,
              //               child: ProductDetailsScreen(
              //                 productID: state.params["productID"]!,
              //               ));
              //         },
              //       ),
              //     ]),
            // ]),
        // GoRoute(
        //     name: RouteConst.kAuth,
        //     path: "/auth",
        //     pageBuilder: (context, state) =>
        //         CupertinoPage(key: state.pageKey, child: AuthScreen()),
        //     routes: [
        //       GoRoute(
        //         name: RouteConst.kOtp,
        //         path: "otp",
        //         pageBuilder: (context, state) =>
        //             CupertinoPage(key: state.pageKey, child: OtpScreen("")),
        //       ),
        //     ]),
        // GoRoute(
        //   name: RouteConst.kCategory,
        //   path: "/category/:categoryTitle",
        //   pageBuilder: (context, state) {
        //     return CupertinoPage(
        //         key: state.pageKey,
        //         child: CategoryDetails(
        //             categoryTitle: state.params["categoryTitle"]!));
        //   },
        // ),
      ]);
}
