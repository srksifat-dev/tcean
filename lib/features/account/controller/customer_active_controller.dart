import 'package:flutter/widgets.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      //TODO: Active status turn off fuction
    }
  }
}
