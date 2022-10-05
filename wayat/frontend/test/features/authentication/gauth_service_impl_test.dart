import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';

import 'gauth_service_impl_test.mocks.dart';

@GenerateMocks([UserState, GoogleAuthService])
void main() async {
  late GoogleAuthService gauth;
  late String value;

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<GoogleAuthService>(MockGoogleAuthService());
    gauth = GetIt.I.get<GoogleAuthService>();
  });

  testWidgets('getIdToken returns empty string', (tester) async {
    when(gauth.getIdToken()).thenAnswer((_) => Future<String>.value(''));

    value = await gauth.getIdToken();
    expect(value, '');
  });
}
