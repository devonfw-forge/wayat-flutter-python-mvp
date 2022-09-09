// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  static FirebaseOptions get currentPlatformOptions {
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.get('WEB_API_KEY'),
    appId: dotenv.get('WEB_APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: dotenv.get('PROJECT_ID'),
    authDomain: dotenv.get('WEB_AUTH_DOMAIN'),
    storageBucket: dotenv.get('STORAGE_BUCKET'),
    measurementId: dotenv.get('WEB_MEASUREMENT_ID'),
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('ANDROID_API_KEY'),
    appId: dotenv.get('ANDROID_APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: dotenv.get('PROJECT_ID'),
    storageBucket: dotenv.get('STORAGE_BUCKET'),
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.get('IOS_API_KEY'),
    appId: dotenv.get('IOS_APP_ID'),
    messagingSenderId: dotenv.get('MESSAGING_SENDER_ID'),
    projectId: dotenv.get('PROJECT_ID'),
    storageBucket: dotenv.get('STORAGE_BUCKET'),
    androidClientId: dotenv.get('IOS_ANDROID_CLIENT_ID'),
    iosClientId: dotenv.get('IOS_CLIENT_ID'),
    iosBundleId: dotenv.get('IOS_BUNDLE_ID'),
  );
}