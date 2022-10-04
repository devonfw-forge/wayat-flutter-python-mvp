import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/location_listener/map_status_service.dart';

part 'map_state.g.dart';

/// A state of the displayed map
// ignore: library_private_types_in_public_api
class MapState = _MapState with _$MapState;

/// Implementation of the state of the displayed map
abstract class _MapState with Store {
  /// HTTP service of the map status
  final MapStatusService mapStatusService;

  /// [Timer] instance to launch periodic requests of map status every [durationInterval]
  Timer? timer;

  /// Time between request of status map
  Duration durationInterval = const Duration(seconds: 60);

  /// Whether map is currently displayed
  @observable
  bool mapOpened = true;

  _MapState({MapStatusService? mapStatusService})
      : mapStatusService = mapStatusService ?? MapStatusService();

  /// Sets and send the state to open
  @action
  Future<void> openMap() async {
    SessionState sessionState = GetIt.I.get<SessionState>();
    // First checks if the user is logged in
    if (sessionState.currentUser == null) return;

    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer.periodic(durationInterval, (timer) async {
      // User can log out in any moment
      if (sessionState.currentUser != null) {
        await mapStatusService.sendMapOpened();
      }
    });
    await mapStatusService.sendMapOpened();
    mapOpened = true;
  }

  /// Sents and send the state to close
  @action
  Future<void> closeMap() async {
    if (timer != null && timer!.isActive) timer!.cancel();

    SessionState sessionState = GetIt.I.get<SessionState>();
    // First checks if the user is logged in
    if (sessionState.currentUser == null) return;

    await mapStatusService.sendMapClosed();
    mapOpened = false;
  }
}
