import 'package:mobx/mobx.dart';

part 'map_controller.g.dart';

class MapController = _MapController with _$MapController;

abstract class _MapController with Store {
  @observable
  bool sharingLocation = false;

  @action
  void setSharingLocation(bool newValue) {
    sharingLocation = newValue;
  }
}
