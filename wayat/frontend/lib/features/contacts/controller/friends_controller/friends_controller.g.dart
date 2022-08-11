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

  late final _$contactsAtom =
      Atom(name: '_FriendsController.contacts', context: context);

  @override
  ObservableList<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$updateContactsAsyncAction =
      AsyncAction('_FriendsController.updateContacts', context: context);

  @override
  Future<dynamic> updateContacts() {
    return _$updateContactsAsyncAction.run(() => super.updateContacts());
  }

  late final _$_FriendsControllerActionController =
      ActionController(name: '_FriendsController', context: context);

  @override
  void removeContact(Contact contact) {
    final _$actionInfo = _$_FriendsControllerActionController.startAction(
        name: '_FriendsController.removeContact');
    try {
      return super.removeContact(contact);
    } finally {
      _$_FriendsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
availableContacts: ${availableContacts},
unavailableContacts: ${unavailableContacts}
    ''';
  }
}
