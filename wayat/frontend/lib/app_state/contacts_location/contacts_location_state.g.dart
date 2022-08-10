// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_location_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactsLocationState on _ContactsLocationState, Store {
  late final _$contactsAtom =
      Atom(name: '_ContactsLocationState.contacts', context: context);

  @override
  List<ContactLocation> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<ContactLocation> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$_ContactsLocationStateActionController =
      ActionController(name: '_ContactsLocationState', context: context);

  @override
  void setContactList(List<ContactLocation> newContacts) {
    final _$actionInfo = _$_ContactsLocationStateActionController.startAction(
        name: '_ContactsLocationState.setContactList');
    try {
      return super.setContactList(newContacts);
    } finally {
      _$_ContactsLocationStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts}
    ''';
  }
}
