// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_group_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageGroupController on _ManageGroupController, Store {
  late final _$groupAtom =
      Atom(name: '_ManageGroupController.group', context: context);

  @override
  Group get group {
    _$groupAtom.reportRead();
    return super.group;
  }

  @override
  set group(Group value) {
    _$groupAtom.reportWrite(value, super.group, () {
      super.group = value;
    });
  }

  late final _$selectedContactsAtom =
      Atom(name: '_ManageGroupController.selectedContacts', context: context);

  @override
  List<Contact> get selectedContacts {
    _$selectedContactsAtom.reportRead();
    return super.selectedContacts;
  }

  @override
  set selectedContacts(List<Contact> value) {
    _$selectedContactsAtom.reportWrite(value, super.selectedContacts, () {
      super.selectedContacts = value;
    });
  }

  late final _$_ManageGroupControllerActionController =
      ActionController(name: '_ManageGroupController', context: context);

  @override
  void addContact(Contact contact) {
    final _$actionInfo = _$_ManageGroupControllerActionController.startAction(
        name: '_ManageGroupController.addContact');
    try {
      return super.addContact(contact);
    } finally {
      _$_ManageGroupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeContact(Contact contact) {
    final _$actionInfo = _$_ManageGroupControllerActionController.startAction(
        name: '_ManageGroupController.removeContact');
    try {
      return super.removeContact(contact);
    } finally {
      _$_ManageGroupControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
group: ${group},
selectedContacts: ${selectedContacts}
    ''';
  }
}
