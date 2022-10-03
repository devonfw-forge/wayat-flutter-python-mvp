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
import 'package:wayat/services/status/map_status_service.dart';

import 'map_state_test.mocks.dart';

@GenerateMocks([LifeCycleService, SessionState, HttpProvider])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
  });

  test("Map State initial state is correct", () {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);

    expect(mapState.timer, null);
    expect(mapState.durationInterval, const Duration(seconds: 60));
    expect(mapState.isAppOpened, true);
  });

  test("Open map is not sent if there is no user", () {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.notifyOpenMap();

    verifyNever(mockMapStatusService.sendMapOpened());
  });

  test("Open map is sent if there is user", () {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));

    mapState.notifyOpenMap();

    verify(mockMapStatusService.sendMapOpened()).called(1);
    expect(mapState.isAppOpened, true);
  });

  test("Periodic open map calls are made", () async {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);
    mapState.durationInterval = const Duration(seconds: 2);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));

    mapState.notifyOpenMap();

    await Future.delayed(const Duration(seconds: 2), () {});

    verify(mockMapStatusService.sendMapOpened()).called(2);
    expect(mapState.isAppOpened, true);
  });

  test("Timer cancels if active when close map is called", () {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.timer = Timer(mapState.durationInterval, () {});

    expect(mapState.timer!.isActive, true);

    mapState.notifyCloseMap();

    expect(mapState.timer!.isActive, false);
  });

  test("The map is not closed if there is no user", () {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.timer = Timer(mapState.durationInterval, () {});

    mapState.notifyCloseMap();

    verifyNever(mockMapStatusService.sendMapClosed());
  });

  test("The map is closed if there is a user", () async {
    LifeCycleService mockMapStatusService = MockLifeCycleService();
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));
    when(mockMapStatusService.sendMapClosed())
        .thenAnswer((_) => Future.value(null));

    LifeCycleState mapState =
        LifeCycleState(mapStatusService: mockMapStatusService);

    await mapState.notifyOpenMap();

    expect(mapState.isAppOpened, true);

    await mapState.notifyCloseMap();

    expect(mapState.isAppOpened, false);
    verify(mockMapStatusService.sendMapClosed()).called(1);
  });

  test("MapState can be created without controller", () async {
    await dotenv.load(fileName: ".env");
    // ignore: unused_local_variable
    LifeCycleState mapState = LifeCycleState();
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
