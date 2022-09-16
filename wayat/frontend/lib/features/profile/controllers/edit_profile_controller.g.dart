// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditProfileController on _EditProfileController, Store {
  late final _$phoneNumberAtom =
      Atom(name: '_EditProfileController.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$errorPhoneVerificationMsgAtom = Atom(
      name: '_EditProfileController.errorPhoneVerificationMsg',
      context: context);

  @override
  String get errorPhoneVerificationMsg {
    _$errorPhoneVerificationMsgAtom.reportRead();
    return super.errorPhoneVerificationMsg;
  }

  @override
  set errorPhoneVerificationMsg(String value) {
    _$errorPhoneVerificationMsgAtom
        .reportWrite(value, super.errorPhoneVerificationMsg, () {
      super.errorPhoneVerificationMsg = value;
    });
  }

  late final _$errorPhoneFormatAtom =
      Atom(name: '_EditProfileController.errorPhoneFormat', context: context);

  @override
  String get errorPhoneFormat {
    _$errorPhoneFormatAtom.reportRead();
    return super.errorPhoneFormat;
  }

  @override
  set errorPhoneFormat(String value) {
    _$errorPhoneFormatAtom.reportWrite(value, super.errorPhoneFormat, () {
      super.errorPhoneFormat = value;
    });
  }

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
  void setNewPhoneNumber(String phone) {
    final _$actionInfo = _$_EditProfileControllerActionController.startAction(
        name: '_EditProfileController.setNewPhoneNumber');
    try {
      return super.setNewPhoneNumber(phone);
    } finally {
      _$_EditProfileControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorPhoneMsg(String msg) {
    final _$actionInfo = _$_EditProfileControllerActionController.startAction(
        name: '_EditProfileController.setErrorPhoneMsg');
    try {
      return super.setErrorPhoneMsg(msg);
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
  String validatePhoneNumber(dynamic textValue) {
    final _$actionInfo = _$_EditProfileControllerActionController.startAction(
        name: '_EditProfileController.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(textValue);
    } finally {
      _$_EditProfileControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
errorPhoneVerificationMsg: ${errorPhoneVerificationMsg},
errorPhoneFormat: ${errorPhoneFormat},
name: ${name},
currentSelectedImage: ${currentSelectedImage},
validPhone: ${validPhone}
    ''';
  }
}
