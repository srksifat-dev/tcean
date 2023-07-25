import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcean/core/common/error_text.dart';
import 'package:tcean/core/common/loader.dart';
import 'package:tcean/core/providers/go_router_provider.dart';
import 'package:tcean/features/auth/controller/auth_controller.dart';
import 'package:tcean/models/user.dart';
import 'package:tcean/core/constants/route_const.dart';
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // UserModel? userModel;

  // void getData(WidgetRef ref, User user) async {
  //   userModel = await ref
  //       .watch(authControllerProvider.notifier)
  //       .getUserData(user.uid)
  //       .first;

  //   ref.read(userProvider.notifier).update((state) => userModel);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightDynamic,
              textTheme: textTheme,
              appBarTheme: appBarTheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkDynamic,
              textTheme: textTheme,
              appBarTheme: appBarTheme,
            ),
            themeMode: ThemeMode.system,
            routerConfig: goRouter);
      },
    );
  }
}
