// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapState on _MapState, Store {
  late final _$mapOpenedAtom =
      Atom(name: '_MapState.mapOpened', context: context);

  @override
  bool get mapOpened {
    _$mapOpenedAtom.reportRead();
    return super.mapOpened;
  }

  @override
  set mapOpened(bool value) {
    _$mapOpenedAtom.reportWrite(value, super.mapOpened, () {
      super.mapOpened = value;
    });
  }

  late final _$openMapAsyncAction =
      AsyncAction('_MapState.openMap', context: context);

  @override
  Future<void> openMap() {
    return _$openMapAsyncAction.run(() => super.openMap());
  }

  late final _$closeMapAsyncAction =
      AsyncAction('_MapState.closeMap', context: context);

  @override
  Future<void> closeMap() {
    return _$closeMapAsyncAction.run(() => super.closeMap());
  }

  @override
  String toString() {
    return '''
mapOpened: ${mapOpened}
    ''';
  }
}
