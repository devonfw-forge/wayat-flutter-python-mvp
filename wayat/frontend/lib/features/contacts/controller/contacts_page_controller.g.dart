// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactsPageController on _ContactsPageController, Store {
  late final _$currentPageAtom =
      Atom(name: '_ContactsPageController.currentPage', context: context);

  @override
  ContactsCurrentPages get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(ContactsCurrentPages value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$_ContactsPageControllerActionController =
      ActionController(name: '_ContactsPageController', context: context);

  @override
  void setContactsCurrentPage(ContactsCurrentPages currentPage) {
    final _$actionInfo = _$_ContactsPageControllerActionController.startAction(
        name: '_ContactsPageController.setContactsCurrentPage');
    try {
      return super.setContactsCurrentPage(currentPage);
    } finally {
      _$_ContactsPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchBarText(String text) {
    final _$actionInfo = _$_ContactsPageControllerActionController.startAction(
        name: '_ContactsPageController.setSearchBarText');
    try {
      return super.setSearchBarText(text);
    } finally {
      _$_ContactsPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage}
    ''';
  }
}
