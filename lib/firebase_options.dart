// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1Ezhvfjrq4zx5kaWC8xa-y3nCcImLPVo',
    appId: '1:978596249741:web:7e85738bcff926843aa2c4',
    messagingSenderId: '978596249741',
    projectId: 'tcean-878ef',
    authDomain: 'tcean-878ef.firebaseapp.com',
    storageBucket: 'tcean-878ef.appspot.com',
    measurementId: 'G-TKJS7PV7B4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8D4WRsZsUtxwdghSrAEbBS_FlFfYEqCI',
    appId: '1:978596249741:android:d888692e3a9b17123aa2c4',
    messagingSenderId: '978596249741',
    projectId: 'tcean-878ef',
    storageBucket: 'tcean-878ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTCxQVIwfI0OMCUOp23K0c5uIjY2jQDko',
    appId: '1:978596249741:ios:6f48a86a7024700b3aa2c4',
    messagingSenderId: '978596249741',
    projectId: 'tcean-878ef',
    storageBucket: 'tcean-878ef.appspot.com',
    iosClientId: '978596249741-cuuqv161g2g4ria44c0qr7e233m9embr.apps.googleusercontent.com',
    iosBundleId: 'software.headlost.tcean',
  );
}