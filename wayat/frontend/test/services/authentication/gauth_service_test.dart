import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:wayat/services/authentication/gauth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'package:wayat/services/request/request_service.dart';
import 'package:wayat/services/request/request_service_impl.dart';

void main() {
  test('Google', () async {
    final googleSignIn = MockGoogleSignIn();
    dotenv.testLoad(mergeWith:  {
      "BASE_URL": 'http://localhost:8080',
      "URL_PREFIX": 'http://127.0.0.1:8000',
      "ANDROID_URL_PREFIX": 'http://10.0.2.2:8000'
    });
    GoogleAuthService googleAuthService = GoogleAuthServiceImpl(gS: googleSignIn);
    
  GetIt.I.registerLazySingleton<GoogleAuthService>(
      () => GoogleAuthServiceImpl(gS: googleSignIn));
  GetIt.I.registerLazySingleton<RequestService>(
      () => RequestServiceImpl());
      
    expect(googleAuthService, isNotNull);
  });
}