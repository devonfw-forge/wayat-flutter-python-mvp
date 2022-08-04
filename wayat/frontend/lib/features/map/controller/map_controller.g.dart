// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapController on _MapController, Store {
  late final _$sharingLocationAtom =
      Atom(name: '_MapController.sharingLocation', context: context);

  @override
  bool get sharingLocation {
    _$sharingLocationAtom.reportRead();
    return super.sharingLocation;
  }

  @override
  set sharingLocation(bool value) {
    _$sharingLocationAtom.reportWrite(value, super.sharingLocation, () {
      super.sharingLocation = value;
    });
  }

  late final _$_MapControllerActionController =
      ActionController(name: '_MapController', context: context);

  @override
  void setSharingLocation(bool newValue) {
    final _$actionInfo = _$_MapControllerActionController.startAction(
        name: '_MapController.setSharingLocation');
    try {
      return super.setSharingLocation(newValue);
    } finally {
      _$_MapControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sharingLocation: ${sharingLocation}
    ''';
  }
}
