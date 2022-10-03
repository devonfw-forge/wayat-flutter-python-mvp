// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifecycle_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LifeCycleState on _LifeCycleState, Store {
  late final _$isAppOpenedAtom =
      Atom(name: '_LifeCycleState.isAppOpened', context: context);

  @override
  bool get isAppOpened {
    _$isAppOpenedAtom.reportRead();
    return super.isAppOpened;
  }

  @override
  set isAppOpened(bool value) {
    _$isAppOpenedAtom.reportWrite(value, super.isAppOpened, () {
      super.isAppOpened = value;
    });
  }

  late final _$notifyOpenMapAsyncAction =
      AsyncAction('_LifeCycleState.notifyOpenMap', context: context);

  @override
  Future<void> notifyOpenMap() {
    return _$notifyOpenMapAsyncAction.run(() => super.notifyOpenMap());
  }

  late final _$notifyCloseMapAsyncAction =
      AsyncAction('_LifeCycleState.notifyCloseMap', context: context);

  @override
  Future<void> notifyCloseMap() {
    return _$notifyCloseMapAsyncAction.run(() => super.notifyCloseMap());
  }

  @override
  String toString() {
    return '''
isAppOpened: ${isAppOpened}
    ''';
  }
}
