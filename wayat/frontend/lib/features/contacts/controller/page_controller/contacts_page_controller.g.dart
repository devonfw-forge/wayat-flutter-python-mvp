// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactsPageController on _ContactsPageController, Store {
  late final _$viewSentRequestsAtom =
      Atom(name: '_ContactsPageController.viewSentRequests', context: context);

  @override
  bool get viewSentRequests {
    _$viewSentRequestsAtom.reportRead();
    return super.viewSentRequests;
  }

  @override
  set viewSentRequests(bool value) {
    _$viewSentRequestsAtom.reportWrite(value, super.viewSentRequests, () {
      super.viewSentRequests = value;
    });
  }

  late final _$_ContactsPageControllerActionController =
      ActionController(name: '_ContactsPageController', context: context);

  @override
  void setviewSentRequests(bool view) {
    final _$actionInfo = _$_ContactsPageControllerActionController.startAction(
        name: '_ContactsPageController.setviewSentRequests');
    try {
      return super.setviewSentRequests(view);
    } finally {
      _$_ContactsPageControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewSentRequests: ${viewSentRequests}
    ''';
  }
}
