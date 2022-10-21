import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/app_config/env_model.dart';

void main() async {
  setUpAll(() async {
    await EnvModel.loadEnvFile('testenv');
  });

  test("Env variables are correctly read", () {
    expect(EnvModel.ANDROID_API_KEY, "android_api_key");
    expect(EnvModel.ANDROID_APP_ID, "android_app_id");
    expect(EnvModel.BASE_URL, "http://testurl.com");
    expect(EnvModel.FIREBASE_APP_NAME, "firebase_app_name");
    expect(EnvModel.IOS_ANDROID_CLIENT_ID, "ios_android_client_id");
    expect(EnvModel.IOS_API_KEY, "ios_api_key");
    expect(EnvModel.IOS_APP_ID, "ios_app_id");
    expect(EnvModel.IOS_CLIENT_ID, "ios_client_id");
    expect(EnvModel.IOS_BUNDLE_ID, "ios_bundle_id");
    expect(EnvModel.MAPS_STATIC_SECRET, "maps_static_secret");
    expect(EnvModel.MESSAGING_SENDER_ID, "messaging_sender_id");
    expect(EnvModel.PROJECT_ID, "project_id");
    expect(EnvModel.STORAGE_BUCKET, "storage_bucket");
    expect(EnvModel.WEB_API_KEY, "web_api_key");
    expect(EnvModel.WEB_AUTH_DOMAIN, "web_auth_domain");
    expect(EnvModel.WEB_CLIENT_ID, "web_client_id");
    expect(EnvModel.WEB_MEASUREMENT_ID, "web_measurement_id");
    expect(EnvModel.WEB_APP_ID, "web_app_id");
  });

  test("clean works", () {
    EnvModel.clean();
    expect(dotenv.get("ANDROID_API_KEY", fallback: "null"), "null");
  });
}
