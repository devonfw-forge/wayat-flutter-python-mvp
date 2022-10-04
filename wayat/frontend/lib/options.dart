// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/common/app_config/env_model.dart';

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
class CustomFirebaseOptions {
  static FirebaseOptions get currentPlatformOptions {
    if (PlatformService().isWeb) {
      return web;
    }
    switch (PlatformService().targetPlatform) {
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
    apiKey: EnvModel.WEB_API_KEY,
    appId: EnvModel.WEB_APP_ID,
    messagingSenderId: EnvModel.MESSAGING_SENDER_ID,
    projectId: EnvModel.PROJECT_ID,
    authDomain: EnvModel.WEB_AUTH_DOMAIN,
    storageBucket: EnvModel.STORAGE_BUCKET,
    measurementId: EnvModel.WEB_MEASUREMENT_ID,
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: EnvModel.ANDROID_API_KEY,
    appId: EnvModel.ANDROID_APP_ID,
    messagingSenderId: EnvModel.MESSAGING_SENDER_ID,
    projectId: EnvModel.PROJECT_ID,
    storageBucket: EnvModel.STORAGE_BUCKET,
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: EnvModel.IOS_API_KEY,
    appId: EnvModel.IOS_APP_ID,
    messagingSenderId: EnvModel.MESSAGING_SENDER_ID,
    projectId: EnvModel.PROJECT_ID,
    storageBucket: EnvModel.STORAGE_BUCKET,
    androidClientId: EnvModel.IOS_ANDROID_CLIENT_ID,
    iosClientId: EnvModel.IOS_CLIENT_ID,
    iosBundleId: EnvModel.IOS_BUNDLE_ID,
  );
}
