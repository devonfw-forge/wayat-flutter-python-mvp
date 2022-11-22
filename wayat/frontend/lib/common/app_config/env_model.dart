import 'package:envied/envied.dart';

part 'env_model.g.dart';

/// Wrapper class for all environment varaibles needed to run the app
@Envied(path: '.env', obfuscate: true)
abstract class EnvModel {
  /// Backend service base url
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String BASE_URL = _EnvModel.BASE_URL;

  /// Current app name used to create a new instance of platform
  /// fireface service
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String FIREBASE_APP_NAME = _EnvModel.FIREBASE_APP_NAME;

  /// Google Cloud project id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String PROJECT_ID = _EnvModel.PROJECT_ID;

  /// Google Cloud messaging sender id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String MESSAGING_SENDER_ID = _EnvModel.MESSAGING_SENDER_ID;

  /// Google Cloud storage bucket
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String STORAGE_BUCKET = _EnvModel.STORAGE_BUCKET;

  /// Maps static service secret, for urls signing
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String MAPS_STATIC_SECRET = _EnvModel.MAPS_STATIC_SECRET;

  /// Google Cloud web client id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String WEB_CLIENT_ID = _EnvModel.WEB_CLIENT_ID;

  /// Google Cloud web api key
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String WEB_API_KEY = _EnvModel.WEB_API_KEY;

  /// Google Cloud web app id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String WEB_APP_ID = _EnvModel.WEB_APP_ID;

  /// Google Cloud web auth domain
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String WEB_AUTH_DOMAIN = _EnvModel.WEB_AUTH_DOMAIN;

  /// Google Cloud web measurement id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String WEB_MEASUREMENT_ID = _EnvModel.WEB_MEASUREMENT_ID;

  /// Google Cloud android api key
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String ANDROID_API_KEY = _EnvModel.ANDROID_API_KEY;

  /// Google Cloud android app id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String ANDROID_APP_ID = _EnvModel.ANDROID_APP_ID;

  /// Google Cloud ios api key
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String IOS_API_KEY = _EnvModel.IOS_API_KEY;

  /// Google Cloud ios app id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String IOS_APP_ID = _EnvModel.IOS_APP_ID;

  /// Google Cloud ios android client id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String IOS_ANDROID_CLIENT_ID = _EnvModel.IOS_ANDROID_CLIENT_ID;

  /// Google Cloud ios client id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String IOS_CLIENT_ID = _EnvModel.IOS_CLIENT_ID;

  /// Google Cloud ios bundle id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String IOS_BUNDLE_ID = _EnvModel.IOS_BUNDLE_ID;

  /// Google Cloud desktop client id
  @EnviedField()
  // ignore: non_constant_identifier_names
  static final String DESKTOP_CLIENT_ID = _EnvModel.DESKTOP_CLIENT_ID;
}
