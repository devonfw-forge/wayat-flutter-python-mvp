// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendsController on _FriendsController, Store {
  Computed<List<Contact>>? _$availableContactsComputed;

  @override
  List<Contact> get availableContacts => (_$availableContactsComputed ??=
          Computed<List<Contact>>(() => super.availableContacts,
              name: '_FriendsController.availableContacts'))
      .value;
  Computed<List<Contact>>? _$unavailableContactsComputed;

  @override
  List<Contact> get unavailableContacts => (_$unavailableContactsComputed ??=
          Computed<List<Contact>>(() => super.unavailableContacts,
              name: '_FriendsController.unavailableContacts'))
      .value;

  late final _$filteredContactsAtom =
      Atom(name: '_FriendsController.filteredContacts', context: context);

  @override
  ObservableList<Contact> get filteredContacts {
    _$filteredContactsAtom.reportRead();
    return super.filteredContacts;
  }

  @override
  set filteredContacts(ObservableList<Contact> value) {
    _$filteredContactsAtom.reportWrite(value, super.filteredContacts, () {
      super.filteredContacts = value;
    });
  }

  late final _$updateContactsAsyncAction =
      AsyncAction('_FriendsController.updateContacts', context: context);

  @override
  Future<void> updateContacts() {
    return _$updateContactsAsyncAction.run(() => super.updateContacts());
  }

  late final _$removeContactAsyncAction =
      AsyncAction('_FriendsController.removeContact', context: context);

  @override
  Future<void> removeContact(Contact contact) {
    return _$removeContactAsyncAction.run(() => super.removeContact(contact));
  }

  late final _$_FriendsControllerActionController =
      ActionController(name: '_FriendsController', context: context);

  @override
  void setTextFilter(String text) {
    final _$actionInfo = _$_FriendsControllerActionController.startAction(
        name: '_FriendsController.setTextFilter');
    try {
      return super.setTextFilter(text);
    } finally {
      _$_FriendsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addContact(Contact contact) {
    final _$actionInfo = _$_FriendsControllerActionController.startAction(
        name: '_FriendsController.addContact');
    try {
      return super.addContact(contact);
    } finally {
      _$_FriendsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filteredContacts: ${filteredContacts},
availableContacts: ${availableContacts},
unavailableContacts: ${unavailableContacts}
    ''';
  }
}
