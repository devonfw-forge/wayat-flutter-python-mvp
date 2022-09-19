// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_verification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhoneVerificationController on _PhoneVerificationController, Store {
  late final _$phoneNumberAtom =
      Atom(name: '_PhoneVerificationController.phoneNumber', context: context);

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
      name: '_PhoneVerificationController.errorPhoneVerificationMsg',
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

  late final _$errorPhoneFormatAtom = Atom(
      name: '_PhoneVerificationController.errorPhoneFormat', context: context);

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

  late final _$validPhoneAtom =
      Atom(name: '_PhoneVerificationController.validPhone', context: context);

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

  late final _$_PhoneVerificationControllerActionController =
      ActionController(name: '_PhoneVerificationController', context: context);

  @override
  void setNewPhoneNumber(String phone) {
    final _$actionInfo = _$_PhoneVerificationControllerActionController
        .startAction(name: '_PhoneVerificationController.setNewPhoneNumber');
    try {
      return super.setNewPhoneNumber(phone);
    } finally {
      _$_PhoneVerificationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValidPhoneNumber(String phone) {
    final _$actionInfo = _$_PhoneVerificationControllerActionController
        .startAction(name: '_PhoneVerificationController.setValidPhoneNumber');
    try {
      return super.setValidPhoneNumber(phone);
    } finally {
      _$_PhoneVerificationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorPhoneMsg(String msg) {
    final _$actionInfo = _$_PhoneVerificationControllerActionController
        .startAction(name: '_PhoneVerificationController.setErrorPhoneMsg');
    try {
      return super.setErrorPhoneMsg(msg);
    } finally {
      _$_PhoneVerificationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String validatePhoneNumber(dynamic textValue) {
    final _$actionInfo = _$_PhoneVerificationControllerActionController
        .startAction(name: '_PhoneVerificationController.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(textValue);
    } finally {
      _$_PhoneVerificationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
phoneNumber: ${phoneNumber},
errorPhoneVerificationMsg: ${errorPhoneVerificationMsg},
errorPhoneFormat: ${errorPhoneFormat},
validPhone: ${validPhone}
    ''';
  }
}
