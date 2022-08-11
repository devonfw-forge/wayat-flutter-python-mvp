// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationState on _LocationState, Store {
  late final _$currentLocationAtom =
      Atom(name: '_LocationState.currentLocation', context: context);

  @override
  LatLng get currentLocation {
    _$currentLocationAtom.reportRead();
    return super.currentLocation;
  }

  @override
  set currentLocation(LatLng value) {
    _$currentLocationAtom.reportWrite(value, super.currentLocation, () {
      super.currentLocation = value;
    });
  }

  late final _$locationModeAtom =
      Atom(name: '_LocationState.locationMode', context: context);

  @override
  ShareLocationMode get locationMode {
    _$locationModeAtom.reportRead();
    return super.locationMode;
  }

  @override
  set locationMode(ShareLocationMode value) {
    _$locationModeAtom.reportWrite(value, super.locationMode, () {
      super.locationMode = value;
    });
  }

  late final _$shareLocationEnabledAtom =
      Atom(name: '_LocationState.shareLocationEnabled', context: context);

  @override
  bool get shareLocationEnabled {
    _$shareLocationEnabledAtom.reportRead();
    return super.shareLocationEnabled;
  }

  @override
  set shareLocationEnabled(bool value) {
    _$shareLocationEnabledAtom.reportWrite(value, super.shareLocationEnabled,
        () {
      super.shareLocationEnabled = value;
    });
  }

  late final _$_LocationStateActionController =
      ActionController(name: '_LocationState', context: context);

  @override
  void setLocationMode(ShareLocationMode newMode) {
    final _$actionInfo = _$_LocationStateActionController.startAction(
        name: '_LocationState.setLocationMode');
    try {
      return super.setLocationMode(newMode);
    } finally {
      _$_LocationStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShareLocationEnabled(bool shareLocation) {
    final _$actionInfo = _$_LocationStateActionController.startAction(
        name: '_LocationState.setShareLocationEnabled');
    try {
      return super.setShareLocationEnabled(shareLocation);
    } finally {
      _$_LocationStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentLocation: ${currentLocation},
locationMode: ${locationMode},
shareLocationEnabled: ${shareLocationEnabled}
    ''';
  }
}
