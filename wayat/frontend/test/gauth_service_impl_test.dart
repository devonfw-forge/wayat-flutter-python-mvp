import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';

import 'gauth_service_impl_test.mocks.dart';

@GenerateMocks([
  SessionState,
  GoogleAuthService
], customMocks: [
  MockSpec<SessionState>(
      as: #MockSessionStateRelaxed, onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GoogleAuthService>(
      as: #MockGoogleAuthServiceRelaxed,
      onMissingStub: OnMissingStub.returnDefault)
])
void main() async {
  late GoogleAuthService gauth;
  late String value;

  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<GoogleAuthService>(MockGoogleAuthService());
    gauth = GetIt.I.get<GoogleAuthService>();
  });

  testWidgets('getIdToken returns empty string', (tester) async {
    when(gauth.getIdToken()).thenAnswer((_) => Future<String>.value(''));

    value = await gauth.getIdToken();
    expect(value, '');
  });
}
