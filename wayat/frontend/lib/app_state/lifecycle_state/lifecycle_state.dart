import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/services/lifecycle/lifecycle_service.dart';

part 'lifecycle_state.g.dart';

/// A state of the app life cycle
// ignore: library_private_types_in_public_api
class LifeCycleState = _LifeCycleState with _$LifeCycleState;

/// Implementation of the state of the app life cycle
abstract class _LifeCycleState with Store {
  /// HTTP service of the app life cycle
  final LifeCycleService lifeCycleService;

  /// [Timer] instance to launch periodic requests of the app life status
  /// every [durationInterval]
  Timer? timer;

  /// Time between request of app life status
  Duration durationInterval = const Duration(seconds: 60);

  /// Whether app is currently oppened
  @observable
  bool isAppOpened = true;

  _LifeCycleState({LifeCycleService? lifeCycleService})
      : lifeCycleService = lifeCycleService ?? LifeCycleService();

  /// Sets and sends the app state to open
  @action
  Future<void> notifyAppOpenned() async {
    UserState sessionState = GetIt.I.get<UserState>();
    // First checks if the user is logged in
    if (sessionState.currentUser == null) return;

    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer.periodic(durationInterval, (timer) async {
      // User can log out in any moment
      if (sessionState.currentUser != null) {
        isAppOpened = true;
        await lifeCycleService.notifyLifeCycleState(isAppOpened);
      }
    });
    isAppOpened = true;
    await lifeCycleService.notifyLifeCycleState(isAppOpened);
  }

  /// Sets and sends the app state to close
  @action
  Future<void> notifyAppClosed() async {
    if (timer != null && timer!.isActive) timer!.cancel();

    UserState sessionState = GetIt.I.get<UserState>();
    // First checks if the user is logged in
    if (sessionState.currentUser == null) return;
    isAppOpened = false;
    await lifeCycleService.notifyLifeCycleState(isAppOpened);
  }
}
