// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCjGfleNzT0zXUm1o2GvdKI7qY6e_3eHl4',
    appId: '1:1085054087381:web:d7b6b3a2bd638e8be7325c',
    messagingSenderId: '1085054087381',
    projectId: 'alexia-d2307',
    authDomain: 'alexia-d2307.firebaseapp.com',
    storageBucket: 'alexia-d2307.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiN4Nn5RtjXZBf8uk8BUwz6AKkiV_89e8',
    appId: '1:1085054087381:android:cadee93c62a6cce4e7325c',
    messagingSenderId: '1085054087381',
    projectId: 'alexia-d2307',
    storageBucket: 'alexia-d2307.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMKUZIGZ4g_c_zGNvF5L0IiIls_BLe1I8',
    appId: '1:1085054087381:ios:264b33cab4b79f27e7325c',
    messagingSenderId: '1085054087381',
    projectId: 'alexia-d2307',
    storageBucket: 'alexia-d2307.firebasestorage.app',
    iosBundleId: 'com.example.lesPetiteCreationsDAlexia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDMKUZIGZ4g_c_zGNvF5L0IiIls_BLe1I8',
    appId: '1:1085054087381:ios:264b33cab4b79f27e7325c',
    messagingSenderId: '1085054087381',
    projectId: 'alexia-d2307',
    storageBucket: 'alexia-d2307.firebasestorage.app',
    iosBundleId: 'com.example.lesPetiteCreationsDAlexia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCjGfleNzT0zXUm1o2GvdKI7qY6e_3eHl4',
    appId: '1:1085054087381:web:eb16b282145c18efe7325c',
    messagingSenderId: '1085054087381',
    projectId: 'alexia-d2307',
    authDomain: 'alexia-d2307.firebaseapp.com',
    storageBucket: 'alexia-d2307.firebasestorage.app',
  );
}
