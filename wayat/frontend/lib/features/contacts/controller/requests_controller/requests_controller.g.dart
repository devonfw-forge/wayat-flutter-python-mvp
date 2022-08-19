// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestsController on _RequestsController, Store {
  late final _$filteredPendingRequestsAtom = Atom(
      name: '_RequestsController.filteredPendingRequests', context: context);

  @override
  ObservableList<Contact> get filteredPendingRequests {
    _$filteredPendingRequestsAtom.reportRead();
    return super.filteredPendingRequests;
  }

  @override
  set filteredPendingRequests(ObservableList<Contact> value) {
    _$filteredPendingRequestsAtom
        .reportWrite(value, super.filteredPendingRequests, () {
      super.filteredPendingRequests = value;
    });
  }

  late final _$pendingRequestsAtom =
      Atom(name: '_RequestsController.pendingRequests', context: context);

  @override
  ObservableList<Contact> get pendingRequests {
    _$pendingRequestsAtom.reportRead();
    return super.pendingRequests;
  }

  @override
  set pendingRequests(ObservableList<Contact> value) {
    _$pendingRequestsAtom.reportWrite(value, super.pendingRequests, () {
      super.pendingRequests = value;
    });
  }

  late final _$sentRequestsAtom =
      Atom(name: '_RequestsController.sentRequests', context: context);

  @override
  ObservableList<Contact> get sentRequests {
    _$sentRequestsAtom.reportRead();
    return super.sentRequests;
  }

  @override
  set sentRequests(ObservableList<Contact> value) {
    _$sentRequestsAtom.reportWrite(value, super.sentRequests, () {
      super.sentRequests = value;
    });
  }

  late final _$updateRequestsAsyncAction =
      AsyncAction('_RequestsController.updateRequests', context: context);

  @override
  Future<void> updateRequests() {
    return _$updateRequestsAsyncAction.run(() => super.updateRequests());
  }

  late final _$sendRequestAsyncAction =
      AsyncAction('_RequestsController.sendRequest', context: context);

  @override
  Future<void> sendRequest(Contact contact) {
    return _$sendRequestAsyncAction.run(() => super.sendRequest(contact));
  }

  late final _$rejectRequestAsyncAction =
      AsyncAction('_RequestsController.rejectRequest', context: context);

  @override
  Future<void> rejectRequest(Contact contact) {
    return _$rejectRequestAsyncAction.run(() => super.rejectRequest(contact));
  }

  late final _$acceptRequestAsyncAction =
      AsyncAction('_RequestsController.acceptRequest', context: context);

  @override
  Future<void> acceptRequest(Contact contact) {
    return _$acceptRequestAsyncAction.run(() => super.acceptRequest(contact));
  }

  late final _$unsendRequestAsyncAction =
      AsyncAction('_RequestsController.unsendRequest', context: context);

  @override
  Future<void> unsendRequest(Contact contact) {
    return _$unsendRequestAsyncAction.run(() => super.unsendRequest(contact));
  }

  late final _$_RequestsControllerActionController =
      ActionController(name: '_RequestsController', context: context);

  @override
  void setTextFilter(String text) {
    final _$actionInfo = _$_RequestsControllerActionController.startAction(
        name: '_RequestsController.setTextFilter');
    try {
      return super.setTextFilter(text);
    } finally {
      _$_RequestsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filteredPendingRequests: ${filteredPendingRequests},
pendingRequests: ${pendingRequests},
sentRequests: ${sentRequests}
    ''';
  }
}
