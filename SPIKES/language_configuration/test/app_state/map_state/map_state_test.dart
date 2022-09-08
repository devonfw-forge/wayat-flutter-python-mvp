import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/status/map_status_service.dart';

import 'map_state_test.mocks.dart';

@GenerateMocks([MapStatusService, SessionState, HttpProvider])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
  });

  test("Map State initial state is correct", () {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);

    expect(mapState.timer, null);
    expect(mapState.durationInterval, const Duration(seconds: 60));
    expect(mapState.mapOpened, true);
  });

  test("Open map is not sent if there is no user", () {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.openMap();

    verifyNever(mockMapStatusService.sendMapOpened());
  });

  test("Open map is sent if there is user", () {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));

    mapState.openMap();

    verify(mockMapStatusService.sendMapOpened()).called(1);
    expect(mapState.mapOpened, true);
  });

  test("Periodic open map calls are made", () async {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);
    mapState.durationInterval = const Duration(seconds: 2);
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));

    mapState.openMap();

    await Future.delayed(const Duration(seconds: 2), () {});

    verify(mockMapStatusService.sendMapOpened()).called(2);
    expect(mapState.mapOpened, true);
  });

  test("Timer cancels if active when close map is called", () {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.timer = Timer(mapState.durationInterval, () {});

    expect(mapState.timer!.isActive, true);

    mapState.closeMap();

    expect(mapState.timer!.isActive, false);
  });

  test("The map is not closed if there is no user", () {
    MapStatusService mockMapStatusService = MockMapStatusService();
    MapState mapState = MapState(mapStatusService: mockMapStatusService);
    when(mockSessionState.currentUser).thenReturn(null);

    mapState.timer = Timer(mapState.durationInterval, () {});

    mapState.closeMap();

    verifyNever(mockMapStatusService.sendMapClosed());
  });

  test("The map is closed if there is a user", () async {
    MapStatusService mockMapStatusService = MockMapStatusService();
    when(mockSessionState.currentUser).thenReturn(_generateMyUser());
    when(mockMapStatusService.sendMapOpened())
        .thenAnswer((_) => Future.value(null));
    when(mockMapStatusService.sendMapClosed())
        .thenAnswer((_) => Future.value(null));

    MapState mapState = MapState(mapStatusService: mockMapStatusService);

    await mapState.openMap();

    expect(mapState.mapOpened, true);

    await mapState.closeMap();

    expect(mapState.mapOpened, false);
    verify(mockMapStatusService.sendMapClosed()).called(1);
  });

  test("MapState can be created without controller", () async {
    await dotenv.load(fileName: ".env");
    MapState mapState = MapState();
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
