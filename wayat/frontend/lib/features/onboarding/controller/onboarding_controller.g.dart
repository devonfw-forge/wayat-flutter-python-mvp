// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingController on _OnboardingController, Store {
  late final _$currentPageAtom =
      Atom(name: '_OnboardingController.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_OnboardingControllerActionController =
      ActionController(name: '_OnboardingController', context: context);

  @override
  void moveToPage(int newPage) {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.moveToPage');
    try {
      return super.moveToPage(newPage);
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
