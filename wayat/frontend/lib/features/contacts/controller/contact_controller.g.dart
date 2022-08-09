// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactController on _ContactController, Store {
  Computed<List<Contact>>? _$availableContactsComputed;

  @override
  List<Contact> get availableContacts => (_$availableContactsComputed ??=
          Computed<List<Contact>>(() => super.availableContacts,
              name: '_ContactController.availableContacts'))
      .value;
  Computed<List<Contact>>? _$unavailableContactsComputed;

  @override
  List<Contact> get unavailableContacts => (_$unavailableContactsComputed ??=
          Computed<List<Contact>>(() => super.unavailableContacts,
              name: '_ContactController.unavailableContacts'))
      .value;

  late final _$_contactsAtom =
      Atom(name: '_ContactController._contacts', context: context);

  @override
  ObservableList<Contact> get _contacts {
    _$_contactsAtom.reportRead();
    return super._contacts;
  }

  @override
  set _contacts(ObservableList<Contact> value) {
    _$_contactsAtom.reportWrite(value, super._contacts, () {
      super._contacts = value;
    });
  }

  late final _$updateContactsAsyncAction =
      AsyncAction('_ContactController.updateContacts', context: context);

  @override
  Future<dynamic> updateContacts() {
    return _$updateContactsAsyncAction.run(() => super.updateContacts());
  }

  @override
  String toString() {
    return '''
availableContacts: ${availableContacts},
unavailableContacts: ${unavailableContacts}
    ''';
  }
}
