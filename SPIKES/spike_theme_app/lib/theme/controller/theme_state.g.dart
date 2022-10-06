// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeState on _ThemeState, Store {
  late final _$selectedThemeModeAtom =
      Atom(name: '_ThemeState.selectedThemeMode', context: context);

  @override
  ThemeMode get selectedThemeMode {
    _$selectedThemeModeAtom.reportRead();
    return super.selectedThemeMode;
  }

  @override
  set selectedThemeMode(ThemeMode value) {
    _$selectedThemeModeAtom.reportWrite(value, super.selectedThemeMode, () {
      super.selectedThemeMode = value;
    });
  }

  late final _$selectedPrimaryColorAtom =
      Atom(name: '_ThemeState.selectedPrimaryColor', context: context);

  @override
  Color get selectedPrimaryColor {
    _$selectedPrimaryColorAtom.reportRead();
    return super.selectedPrimaryColor;
  }

  @override
  set selectedPrimaryColor(Color value) {
    _$selectedPrimaryColorAtom.reportWrite(value, super.selectedPrimaryColor,
        () {
      super.selectedPrimaryColor = value;
    });
  }

  late final _$_ThemeStateActionController =
      ActionController(name: '_ThemeState', context: context);

  @override
  dynamic setSelectedThemeMode(ThemeMode themeMode) {
    final _$actionInfo = _$_ThemeStateActionController.startAction(
        name: '_ThemeState.setSelectedThemeMode');
    try {
      return super.setSelectedThemeMode(themeMode);
    } finally {
      _$_ThemeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedPrimaryColor(Color color) {
    final _$actionInfo = _$_ThemeStateActionController.startAction(
        name: '_ThemeState.setSelectedPrimaryColor');
    try {
      return super.setSelectedPrimaryColor(color);
    } finally {
      _$_ThemeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedThemeMode: ${selectedThemeMode},
selectedPrimaryColor: ${selectedPrimaryColor}
    ''';
  }
}
