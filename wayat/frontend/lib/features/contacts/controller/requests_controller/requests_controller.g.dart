// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestsController on _RequestsController, Store {
  Computed<List<Contact>>? _$pendingRequestsComputed;

  @override
  List<Contact> get pendingRequests => (_$pendingRequestsComputed ??=
          Computed<List<Contact>>(() => super.pendingRequests,
              name: '_RequestsController.pendingRequests'))
      .value;
  Computed<List<Contact>>? _$sentRequestsComputed;

  @override
  List<Contact> get sentRequests => (_$sentRequestsComputed ??=
          Computed<List<Contact>>(() => super.sentRequests,
              name: '_RequestsController.sentRequests'))
      .value;

  late final _$requestsAtom =
      Atom(name: '_RequestsController.requests', context: context);

  @override
  ObservableMap<String, List<Contact>> get requests {
    _$requestsAtom.reportRead();
    return super.requests;
  }

  @override
  set requests(ObservableMap<String, List<Contact>> value) {
    _$requestsAtom.reportWrite(value, super.requests, () {
      super.requests = value;
    });
  }

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

  late final _$updateRequestsAsyncAction =
      AsyncAction('_RequestsController.updateRequests', context: context);

  @override
  Future<dynamic> updateRequests() {
    return _$updateRequestsAsyncAction.run(() => super.updateRequests());
  }

  late final _$_RequestsControllerActionController =
      ActionController(name: '_RequestsController', context: context);

  @override
  void sendRequest(Contact contact) {
    final _$actionInfo = _$_RequestsControllerActionController.startAction(
        name: '_RequestsController.sendRequest');
    try {
      return super.sendRequest(contact);
    } finally {
      _$_RequestsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rejectRequest(Contact contact) {
    final _$actionInfo = _$_RequestsControllerActionController.startAction(
        name: '_RequestsController.rejectRequest');
    try {
      return super.rejectRequest(contact);
    } finally {
      _$_RequestsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void acceptRequest(Contact contact) {
    final _$actionInfo = _$_RequestsControllerActionController.startAction(
        name: '_RequestsController.acceptRequest');
    try {
      return super.acceptRequest(contact);
    } finally {
      _$_RequestsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unsendRequest(Contact contact) {
    final _$actionInfo = _$_RequestsControllerActionController.startAction(
        name: '_RequestsController.unsendRequest');
    try {
      return super.unsendRequest(contact);
    } finally {
      _$_RequestsControllerActionController.endAction(_$actionInfo);
    }
  }

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
requests: ${requests},
filteredPendingRequests: ${filteredPendingRequests},
pendingRequests: ${pendingRequests},
sentRequests: ${sentRequests}
    ''';
  }
}
