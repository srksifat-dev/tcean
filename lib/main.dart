import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/features/auth/controller/auth_controller.dart';
import 'package:tcean/models/user_model.dart';
import 'package:tcean/core/constants/route_const.dart';
import 'package:tcean/router/router.dart';
import 'package:tcean/theme/app_colors.dart';
import 'package:tcean/theme/app_theme.dart';

import 'features/user/controller/user_active_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final observer = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(observer);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

UserModel? userModel;
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  

  void getData(WidgetRef ref, User user) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;

    ref.read(userProvider.notifier).update((state) => userModel);
  }


  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            return DynamicColorBuilder(
              builder: (lightDynamic, darkDynamic) {
                return MaterialApp.router(
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: lightDynamic ?? lightColorScheme,
                    textTheme: textTheme,
                    appBarTheme: appBarTheme,
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    colorScheme: darkDynamic ?? darkColorScheme,
                    textTheme: textTheme,
                    appBarTheme: appBarTheme,
                  ),
                  themeMode: ThemeMode.system,
                  routerConfig: GoRouter(
                      initialLocation: "/${RouteConst.kExplore}",
                      redirect: (context, state) {
                        bool loggedIn = false;
                        if (data != null) {
                          getData(ref, data);
                          if (userModel != null) {
                            loggedIn = true;
                          }
                        } else {
                          loggedIn = false;
                        }
                        final isInCheckout = state.uri.toString() ==
                            "/${RouteConst.kCart}/${RouteConst.kCheckout}";

                        if (!loggedIn && isInCheckout) {
                          return "/${RouteConst.kAuth}";
                        }

                        return null;
                      },
                      routes: routes
                    
                      ),
                );
              },
            );
          },
          error: (error, _) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
