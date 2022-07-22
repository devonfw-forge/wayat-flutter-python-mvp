// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_event_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateEventController on _CreateEventController, Store {
  late final _$nameAtom =
      Atom(name: '_CreateEventController.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateEventController.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$addressAtom =
      Atom(name: '_CreateEventController.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$startDateAtom =
      Atom(name: '_CreateEventController.startDate', context: context);

  @override
  DateTime? get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime? value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: '_CreateEventController.endDate', context: context);

  @override
  DateTime? get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime? value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$_CreateEventControllerActionController =
      ActionController(name: '_CreateEventController', context: context);

  @override
  void setName(String name) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.setName');
    try {
      return super.setName(name);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String description) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.setDescription');
    try {
      return super.setDescription(description);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String address) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.setAddress');
    try {
      return super.setAddress(address);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(DateTime startDate) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.setStartDate');
    try {
      return super.setStartDate(startDate);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndDate(DateTime endDate) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.setEndDate');
    try {
      return super.setEndDate(endDate);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String? name) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.validateName');
    try {
      return super.validateName(name);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescription(String? description) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.validateDescription');
    try {
      return super.validateDescription(description);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAddress(String? address) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.validateAddress');
    try {
      return super.validateAddress(address);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateStartDate(DateTime? startDate) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.validateStartDate');
    try {
      return super.validateStartDate(startDate);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEndDate(DateTime? endDate) {
    final _$actionInfo = _$_CreateEventControllerActionController.startAction(
        name: '_CreateEventController.validateEndDate');
    try {
      return super.validateEndDate(endDate);
    } finally {
      _$_CreateEventControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
description: ${description},
address: ${address},
startDate: ${startDate},
endDate: ${endDate}
    ''';
  }
}
