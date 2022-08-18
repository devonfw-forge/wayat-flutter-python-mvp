import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:wayat/services/status/map_status_service.dart';

part 'map_state.g.dart';

// ignore: library_private_types_in_public_api
class MapState = _MapState with _$MapState;

abstract class _MapState with Store {
  MapStatusService mapStatusService = MapStatusService();

  Timer? timer;

  final Duration durationInterval = const Duration(seconds: 60);
  
  @observable
  bool mapOpened = true;

  @action
  Future<void> openMap() async {
    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer.periodic(durationInterval, (timer) async {
      await mapStatusService.sendMapOpened();
    });
    await mapStatusService.sendMapOpened();
    mapOpened = true;
  }

  @action
  Future<void> closeMap() async {
    if (timer != null && timer!.isActive) timer!.cancel();
    await mapStatusService.sendMapClosed();
    mapOpened = false;
  }
}
