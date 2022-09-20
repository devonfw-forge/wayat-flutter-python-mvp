// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditProfileController on _EditProfileController, Store {
  late final _$nameAtom =
      Atom(name: '_EditProfileController.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$currentSelectedImageAtom = Atom(
      name: '_EditProfileController.currentSelectedImage', context: context);

  @override
  XFile? get currentSelectedImage {
    _$currentSelectedImageAtom.reportRead();
    return super.currentSelectedImage;
  }

  @override
  set currentSelectedImage(XFile? value) {
    _$currentSelectedImageAtom.reportWrite(value, super.currentSelectedImage,
        () {
      super.currentSelectedImage = value;
    });
  }

  late final _$validPhoneAtom =
      Atom(name: '_EditProfileController.validPhone', context: context);

  @override
  bool get validPhone {
    _$validPhoneAtom.reportRead();
    return super.validPhone;
  }

  @override
  set validPhone(bool value) {
    _$validPhoneAtom.reportWrite(value, super.validPhone, () {
      super.validPhone = value;
    });
  }

  late final _$_EditProfileControllerActionController =
      ActionController(name: '_EditProfileController', context: context);

  @override
  void setName(String newName) {
    final _$actionInfo = _$_EditProfileControllerActionController.startAction(
        name: '_EditProfileController.setName');
    try {
      return super.setName(newName);
    } finally {
      _$_EditProfileControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewImage(XFile? image) {
    final _$actionInfo = _$_EditProfileControllerActionController.startAction(
        name: '_EditProfileController.setNewImage');
    try {
      return super.setNewImage(image);
    } finally {
      _$_EditProfileControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
currentSelectedImage: ${currentSelectedImage},
validPhone: ${validPhone}
    ''';
  }
}
