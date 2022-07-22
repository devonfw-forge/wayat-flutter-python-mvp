import 'package:mobx/mobx.dart';

part 'create_event_error_state.g.dart';

class CreateEventErrorState = _CreateEventErrorState
    with _$CreateEventErrorState;

abstract class _CreateEventErrorState with Store {
  @observable
  String? name;

  @observable
  String? description;

  @observable
  String? address;

  @observable
  String? startDate;

  @observable
  String? endDate;

  @computed
  bool get hasErrors =>
      name != null ||
      description != null ||
      address != null ||
      startDate != null ||
      endDate != null;
}
