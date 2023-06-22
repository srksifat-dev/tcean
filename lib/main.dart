import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcean/theme/app_theme.dart';

import 'features/account/controller/customer_active_controller.dart';
import 'routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final observer = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(observer);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}
