import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvModel {
  // ignore: non_constant_identifier_names
  static final String BASE_URL = dotenv.get('BASE_URL')
    .replaceAll("\"", "");
  
  // ignore: non_constant_identifier_names
  static final String FIREBASE_APP_NAME = dotenv.get('FIREBASE_APP_NAME')
    .replaceAll("\"", "");
  
  // ignore: non_constant_identifier_names
  static final String PROJECT_ID = dotenv.get('PROJECT_ID')
    .replaceAll("\"", "");
  
  // ignore: non_constant_identifier_names
  static final String MESSAGING_SENDER_ID = dotenv.get('MESSAGING_SENDER_ID')
    .replaceAll("\"", "");
  
  // ignore: non_constant_identifier_names
  static final String STORAGE_BUCKET = dotenv.get('STORAGE_BUCKET')
    .replaceAll("\"", "");

  // ignore: non_constant_identifier_names
  static final String MAPS_STATIC_SECRET = dotenv.get('MAPS_STATIC_SECRET')
    .replaceAll("\"", "");

  // ignore: non_constant_identifier_names
  static final String WEB_CLIENT_ID = dotenv.get('WEB_CLIENT_ID')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String WEB_API_KEY = dotenv.get('WEB_API_KEY')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String WEB_APP_ID = dotenv.get('WEB_APP_ID')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String WEB_AUTH_DOMAIN = dotenv.get('WEB_AUTH_DOMAIN')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String WEB_MEASUREMENT_ID = dotenv.get('WEB_MEASUREMENT_ID')
    .replaceAll("\"", "");
  
  // ignore: non_constant_identifier_names
  static final String ANDROID_API_KEY = dotenv.get('ANDROID_API_KEY')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String ANDROID_APP_ID = dotenv.get('ANDROID_APP_ID')
    .replaceAll("\"", "");

  // ignore: non_constant_identifier_names
  static final String IOS_API_KEY = dotenv.get('IOS_API_KEY')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String IOS_APP_ID = dotenv.get('IOS_APP_ID')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String IOS_ANDROID_CLIENT_ID = dotenv.get('IOS_ANDROID_CLIENT_ID')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String IOS_CLIENT_ID = dotenv.get('IOS_CLIENT_ID')
    .replaceAll("\"", "");
  // ignore: non_constant_identifier_names
  static final String IOS_BUNDLE_ID = dotenv.get('IOS_BUNDLE_ID')
    .replaceAll("\"", "");

  static Future<void> loadEnvFile([String? filename]) async {
    await dotenv.load(fileName: filename ?? ".env");
  }
}