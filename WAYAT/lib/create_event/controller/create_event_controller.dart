import 'package:mobx/mobx.dart';
import 'package:wayat/create_event/controller/create_event_error_state.dart';

part 'create_event_controller.g.dart';

class CreateEventController = _CreateEventController
    with _$CreateEventController;

abstract class _CreateEventController with Store {
  @observable
  String name = '';

  @observable
  String description = '';

  @observable
  String address = '';

  @observable
  DateTime? startDate;

  @observable
  DateTime? endDate;

  final CreateEventErrorState errorState = CreateEventErrorState();

  late final List<ReactionDisposer> _validationDisposers = [
    reaction((_) => name, validateName),
    reaction((_) => description, validateDescription),
    reaction((_) => address, validateAddress),
    reaction((_) => startDate, validateStartDate),
    reaction((_) => endDate, validateEndDate),
  ];

  @action
  void setName(String name) {
    this.name = name;
  }

  @action
  void setDescription(String description) {
    this.description = description;
  }

  @action
  void setAddress(String address) {
    this.address = address;
  }

  @action
  void setStartDate(DateTime startDate) {
    this.startDate = startDate;
  }

  @action
  void setEndDate(DateTime endDate) {
    this.endDate = endDate;
  }

  @action
  void validateName(String? name) {
    if (name == null || name.isEmpty) {
      errorState.name = 'Name cannot be blank';
      return;
    }
    errorState.name = null;
  }

  @action
  void validateDescription(String? description) {
    if (description == null || description.isEmpty) {
      errorState.description = 'Description cannot be blank';
      return;
    }
    errorState.description = null;
  }

  @action
  void validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      errorState.address = 'Address cannot be blank';
      return;
    }
    errorState.address = null;
  }

  @action
  void validateStartDate(DateTime? startDate) {
    if (startDate == null) {
      errorState.startDate = 'Start Date cannot be blank';
      return;
    }
    if (endDate != null) {
      if (startDate.isAfter(endDate!) || startDate.isAtSameMomentAs(endDate!)) {
        errorState.startDate = 'Start Date must be after End Date';
        return;
      }
    }
    errorState.startDate = null;
  }

  @action
  void validateEndDate(DateTime? endDate) {
    if (endDate == null) {
      errorState.endDate = 'End Date cannot be blank';
      return;
    }
    if (startDate != null) {
      if (endDate.isBefore(startDate!) ||
          endDate.isAtSameMomentAs(startDate!)) {
        errorState.endDate = 'End Date must be before Start Date';
        return;
      }
    }
    errorState.endDate = null;
  }

  void dispose() {
    for (final d in _validationDisposers) {
      d();
    }
  }
}
