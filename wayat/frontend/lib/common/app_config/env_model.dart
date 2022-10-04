import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Wrapper class for all environment varaibles needed to run the app
class EnvModel {

  /// Backend service base url
  // ignore: non_constant_identifier_names
  static final String BASE_URL = dotenv.get('BASE_URL')
    .replaceAll("\"", "");
  
  /// Current app name used to create a new instance of platform 
  /// fireface service 
  // ignore: non_constant_identifier_names
  static final String FIREBASE_APP_NAME = dotenv.get('FIREBASE_APP_NAME')
    .replaceAll("\"", "");
  
  /// Google Cloud project id
  // ignore: non_constant_identifier_names
  static final String PROJECT_ID = dotenv.get('PROJECT_ID')
    .replaceAll("\"", "");
  
  /// Google Cloud messaging sender id
  // ignore: non_constant_identifier_names
  static final String MESSAGING_SENDER_ID = dotenv.get('MESSAGING_SENDER_ID')
    .replaceAll("\"", "");
  
  /// Google Cloud storage bucket
  // ignore: non_constant_identifier_names
  static final String STORAGE_BUCKET = dotenv.get('STORAGE_BUCKET')
    .replaceAll("\"", "");

  /// Maps static service secret, for urls signing
  // ignore: non_constant_identifier_names
  static final String MAPS_STATIC_SECRET = dotenv.get('MAPS_STATIC_SECRET')
    .replaceAll("\"", "");

  /// Google Cloud web client id
  // ignore: non_constant_identifier_names
  static final String WEB_CLIENT_ID = dotenv.get('WEB_CLIENT_ID')
    .replaceAll("\"", "");
  /// Google Cloud web api key
  // ignore: non_constant_identifier_names
  static final String WEB_API_KEY = dotenv.get('WEB_API_KEY')
    .replaceAll("\"", "");
  /// Google Cloud web app id
  // ignore: non_constant_identifier_names
  static final String WEB_APP_ID = dotenv.get('WEB_APP_ID')
    .replaceAll("\"", "");
  /// Google Cloud web auth domain
  // ignore: non_constant_identifier_names
  static final String WEB_AUTH_DOMAIN = dotenv.get('WEB_AUTH_DOMAIN')
    .replaceAll("\"", "");
  /// Google Cloud web measurement id
  // ignore: non_constant_identifier_names
  static final String WEB_MEASUREMENT_ID = dotenv.get('WEB_MEASUREMENT_ID')
    .replaceAll("\"", "");
  
  /// Google Cloud android api key
  // ignore: non_constant_identifier_names
  static final String ANDROID_API_KEY = dotenv.get('ANDROID_API_KEY')
    .replaceAll("\"", "");
  /// Google Cloud android app id
  // ignore: non_constant_identifier_names
  static final String ANDROID_APP_ID = dotenv.get('ANDROID_APP_ID')
    .replaceAll("\"", "");

  /// Google Cloud ios api key
  // ignore: non_constant_identifier_names
  static final String IOS_API_KEY = dotenv.get('IOS_API_KEY')
    .replaceAll("\"", "");
  /// Google Cloud ios app id
  // ignore: non_constant_identifier_names
  static final String IOS_APP_ID = dotenv.get('IOS_APP_ID')
    .replaceAll("\"", "");
  /// Google Cloud ios android client id
  // ignore: non_constant_identifier_names
  static final String IOS_ANDROID_CLIENT_ID = dotenv.get('IOS_ANDROID_CLIENT_ID')
    .replaceAll("\"", "");
  /// Google Cloud ios client id
  // ignore: non_constant_identifier_names
  static final String IOS_CLIENT_ID = dotenv.get('IOS_CLIENT_ID')
    .replaceAll("\"", "");
  /// Google Cloud ios bundle id
  // ignore: non_constant_identifier_names
  static final String IOS_BUNDLE_ID = dotenv.get('IOS_BUNDLE_ID')
    .replaceAll("\"", "");

  /// Loads all the environment variables from a file.
  /// 
  /// Default file name is '.env'
  static Future<void> loadEnvFile([String? filename]) async {
    await dotenv.load(fileName: filename ?? ".env");
  }

  /// Removes all loaded environment variables.
  /// 
  /// Useful for testing
  static void clean() {
    dotenv.clean();
  }
}