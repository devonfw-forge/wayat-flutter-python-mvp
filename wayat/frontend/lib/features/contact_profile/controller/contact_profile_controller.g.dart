// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContactProfileController on _ContactProfileController, Store {
  late final _$shareLocationToContactAtom = Atom(
      name: '_ContactProfileController.shareLocationToContact',
      context: context);

  @override
  bool get shareLocationToContact {
    _$shareLocationToContactAtom.reportRead();
    return super.shareLocationToContact;
  }

  @override
  set shareLocationToContact(bool value) {
    _$shareLocationToContactAtom
        .reportWrite(value, super.shareLocationToContact, () {
      super.shareLocationToContact = value;
    });
  }

  late final _$setShareLocationToContactAsyncAction = AsyncAction(
      '_ContactProfileController.setShareLocationToContact',
      context: context);

  @override
  Future<void> setShareLocationToContact(
      bool shareLocationToContact, Contact contact) {
    return _$setShareLocationToContactAsyncAction.run(
        () => super.setShareLocationToContact(shareLocationToContact, contact));
  }

  @override
  String toString() {
    return '''
shareLocationToContact: ${shareLocationToContact}
    ''';
  }
}
