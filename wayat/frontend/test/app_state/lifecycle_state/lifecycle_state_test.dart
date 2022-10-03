import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/lifecycle/lifecycle_service.dart';

import 'lifecycle_state_test.mocks.dart';

@GenerateMocks([LifeCycleService, SessionState, HttpProvider])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
  });

  test("Map State initial state is correct", () {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);

    expect(lifeCycleState.timer, null);
    expect(lifeCycleState.durationInterval, const Duration(seconds: 60));
    expect(lifeCycleState.isAppOpened, true);
  });

  test("Open map is not sent if there is no user", () {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);
    when(mockSessionState.currentUser).thenReturn(null);

    lifeCycleState.notifyAppOpenned();

    verifyNever(mockLifeCycleService.notifyLifeCycleState(true));
  });

  test("Open map is sent if there is user", () {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockLifeCycleService.notifyLifeCycleState(true))
        .thenAnswer((_) => Future.value(null));

    lifeCycleState.notifyAppOpenned();

    verify(mockLifeCycleService.notifyLifeCycleState(true)).called(1);
    expect(lifeCycleState.isAppOpened, true);
  });

  test("Periodic open map calls are made", () async {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);
    lifeCycleState.durationInterval = const Duration(seconds: 2);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockLifeCycleService.notifyLifeCycleState(true))
        .thenAnswer((_) => Future.value(null));

    lifeCycleState.notifyAppOpenned();

    await Future.delayed(const Duration(seconds: 2), () {});

    verify(mockLifeCycleService.notifyLifeCycleState(true)).called(2);
    expect(lifeCycleState.isAppOpened, true);
  });

  test("Timer cancels if active when close map is called", () {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);
    when(mockSessionState.currentUser).thenReturn(null);

    lifeCycleState.timer = Timer(lifeCycleState.durationInterval, () {});

    expect(lifeCycleState.timer!.isActive, true);

    lifeCycleState.notifyAppClosed();

    expect(lifeCycleState.timer!.isActive, false);
  });

  test("The map is not closed if there is no user", () {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);
    when(mockSessionState.currentUser).thenReturn(null);

    lifeCycleState.timer = Timer(lifeCycleState.durationInterval, () {});

    lifeCycleState.notifyAppClosed();

    verifyNever(mockLifeCycleService.notifyLifeCycleState(false));
  });

  test("The map is closed if there is a user", () async {
    LifeCycleService mockLifeCycleService = MockLifeCycleService();
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockLifeCycleService.notifyLifeCycleState(true))
        .thenAnswer((_) => Future.value(null));
    when(mockLifeCycleService.notifyLifeCycleState(false))
        .thenAnswer((_) => Future.value(null));

    LifeCycleState lifeCycleState =
        LifeCycleState(lifeCycleService: mockLifeCycleService);

    await lifeCycleState.notifyAppOpenned();

    expect(lifeCycleState.isAppOpened, true);

    await lifeCycleState.notifyAppClosed();

    expect(lifeCycleState.isAppOpened, false);
    verify(mockLifeCycleService.notifyLifeCycleState(false)).called(1);
  });

  test("MapState can be created without controller", () async {
    await dotenv.load(fileName: ".env");
    // ignore: unused_local_variable
    LifeCycleState lifeCycleState = LifeCycleState();
  });
}

MyUser _generateMyUser() {
  return MyUser(
      id: "id",
      name: "name",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "123",
      onboardingCompleted: true,
      shareLocationEnabled: true);
}
