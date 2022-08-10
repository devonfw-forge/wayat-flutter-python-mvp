// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on _AppController, Store {
  late final _$counterAtom =
      Atom(name: '_AppController.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$_AppControllerActionController =
      ActionController(name: '_AppController', context: context);

  @override
  void setCounter(int newValue) {
    final _$actionInfo = _$_AppControllerActionController.startAction(
        name: '_AppController.setCounter');
    try {
      return super.setCounter(newValue);
    } finally {
      _$_AppControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
