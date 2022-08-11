// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/phone_validation_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:mobx/mobx.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/app_state/user_session/session_state.dart' as _i6;
import 'package:wayat/domain/user/user.dart' as _i2;
import 'package:wayat/services/authentication/auth_service.dart' as _i3;
import 'package:wayat/services/authentication/gauth_service_impl.dart' as _i8;
import 'package:wayat/services/authentication/gphone_service_impl.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUser_0 extends _i1.SmartFake implements _i2.User {
  _FakeUser_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeAuthService_1 extends _i1.SmartFake implements _i3.AuthService {
  _FakeAuthService_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeGooglePhoneService_2 extends _i1.SmartFake
    implements _i4.GooglePhoneService {
  _FakeGooglePhoneService_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeReactiveContext_3 extends _i1.SmartFake
    implements _i5.ReactiveContext {
  _FakeReactiveContext_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [SessionState].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionState extends _i1.Mock implements _i6.SessionState {
  MockSessionState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get finishLoggedIn => (super
          .noSuchMethod(Invocation.getter(#finishLoggedIn), returnValue: false)
      as bool);
  @override
  set finishLoggedIn(bool? value) =>
      super.noSuchMethod(Invocation.setter(#finishLoggedIn, value),
          returnValueForMissingStub: null);
  @override
  bool get googleSignedIn => (super
          .noSuchMethod(Invocation.getter(#googleSignedIn), returnValue: false)
      as bool);
  @override
  set googleSignedIn(bool? value) =>
      super.noSuchMethod(Invocation.setter(#googleSignedIn, value),
          returnValueForMissingStub: null);
  @override
  bool get phoneValidation => (super
          .noSuchMethod(Invocation.getter(#phoneValidation), returnValue: false)
      as bool);
  @override
  set phoneValidation(bool? value) =>
      super.noSuchMethod(Invocation.setter(#phoneValidation, value),
          returnValueForMissingStub: null);
  @override
  bool get hasDoneOnboarding =>
      (super.noSuchMethod(Invocation.getter(#hasDoneOnboarding),
          returnValue: false) as bool);
  @override
  set hasDoneOnboarding(bool? value) =>
      super.noSuchMethod(Invocation.setter(#hasDoneOnboarding, value),
          returnValueForMissingStub: null);
  @override
  _i2.User get currentUser =>
      (super.noSuchMethod(Invocation.getter(#currentUser),
              returnValue: _FakeUser_0(this, Invocation.getter(#currentUser)))
          as _i2.User);
  @override
  set currentUser(_i2.User? value) =>
      super.noSuchMethod(Invocation.setter(#currentUser, value),
          returnValueForMissingStub: null);
  @override
  String get phoneNumber =>
      (super.noSuchMethod(Invocation.getter(#phoneNumber), returnValue: '')
          as String);
  @override
  set phoneNumber(String? _phoneNumber) =>
      super.noSuchMethod(Invocation.setter(#phoneNumber, _phoneNumber),
          returnValueForMissingStub: null);
  @override
  _i3.AuthService get authService =>
      (super.noSuchMethod(Invocation.getter(#authService),
              returnValue:
                  _FakeAuthService_1(this, Invocation.getter(#authService)))
          as _i3.AuthService);
  @override
  _i4.GooglePhoneService get phoneService => (super.noSuchMethod(
          Invocation.getter(#phoneService),
          returnValue:
              _FakeGooglePhoneService_2(this, Invocation.getter(#phoneService)))
      as _i4.GooglePhoneService);
  @override
  _i5.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_3(this, Invocation.getter(#context)))
          as _i5.ReactiveContext);
  @override
  void doneOnBoarding() =>
      super.noSuchMethod(Invocation.method(#doneOnBoarding, []),
          returnValueForMissingStub: null);
  @override
  _i7.Future<bool> isLogged() =>
      (super.noSuchMethod(Invocation.method(#isLogged, []),
          returnValue: _i7.Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  void setGoogleSignIn(bool? signedIn) =>
      super.noSuchMethod(Invocation.method(#setGoogleSignIn, [signedIn]),
          returnValueForMissingStub: null);
  @override
  void setPhoneValidation(bool? phoneValidated) => super.noSuchMethod(
      Invocation.method(#setPhoneValidation, [phoneValidated]),
      returnValueForMissingStub: null);
  @override
  _i7.Future<dynamic> setFinishLoggedIn(bool? finishedLoggedIn) => (super
      .noSuchMethod(Invocation.method(#setFinishLoggedIn, [finishedLoggedIn]),
          returnValue: _i7.Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<void> finishLoginProcess(_i8.GoogleAuthService? googleAuth) =>
      (super.noSuchMethod(Invocation.method(#finishLoginProcess, [googleAuth]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<void> googleLogin() => (super.noSuchMethod(
      Invocation.method(#googleLogin, []),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
}

/// A class which mocks [SessionState].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionStateRelaxed extends _i1.Mock implements _i6.SessionState {
  @override
  bool get finishLoggedIn =>
      (super.noSuchMethod(Invocation.getter(#finishLoggedIn),
          returnValue: false, returnValueForMissingStub: false) as bool);
  @override
  set finishLoggedIn(bool? value) =>
      super.noSuchMethod(Invocation.setter(#finishLoggedIn, value),
          returnValueForMissingStub: null);
  @override
  bool get googleSignedIn =>
      (super.noSuchMethod(Invocation.getter(#googleSignedIn),
          returnValue: false, returnValueForMissingStub: false) as bool);
  @override
  set googleSignedIn(bool? value) =>
      super.noSuchMethod(Invocation.setter(#googleSignedIn, value),
          returnValueForMissingStub: null);
  @override
  bool get phoneValidation =>
      (super.noSuchMethod(Invocation.getter(#phoneValidation),
          returnValue: false, returnValueForMissingStub: false) as bool);
  @override
  set phoneValidation(bool? value) =>
      super.noSuchMethod(Invocation.setter(#phoneValidation, value),
          returnValueForMissingStub: null);
  @override
  bool get hasDoneOnboarding =>
      (super.noSuchMethod(Invocation.getter(#hasDoneOnboarding),
          returnValue: false, returnValueForMissingStub: false) as bool);
  @override
  set hasDoneOnboarding(bool? value) =>
      super.noSuchMethod(Invocation.setter(#hasDoneOnboarding, value),
          returnValueForMissingStub: null);
  @override
  _i2.User get currentUser =>
      (super.noSuchMethod(Invocation.getter(#currentUser),
          returnValue: _FakeUser_0(this, Invocation.getter(#currentUser)),
          returnValueForMissingStub:
              _FakeUser_0(this, Invocation.getter(#currentUser))) as _i2.User);
  @override
  set currentUser(_i2.User? value) =>
      super.noSuchMethod(Invocation.setter(#currentUser, value),
          returnValueForMissingStub: null);
  @override
  String get phoneNumber => (super.noSuchMethod(Invocation.getter(#phoneNumber),
      returnValue: '', returnValueForMissingStub: '') as String);
  @override
  set phoneNumber(String? _phoneNumber) =>
      super.noSuchMethod(Invocation.setter(#phoneNumber, _phoneNumber),
          returnValueForMissingStub: null);
  @override
  _i3.AuthService get authService => (super.noSuchMethod(
      Invocation.getter(#authService),
      returnValue: _FakeAuthService_1(this, Invocation.getter(#authService)),
      returnValueForMissingStub: _FakeAuthService_1(
          this, Invocation.getter(#authService))) as _i3.AuthService);
  @override
  _i4.GooglePhoneService get phoneService => (super.noSuchMethod(
          Invocation.getter(#phoneService),
          returnValue:
              _FakeGooglePhoneService_2(this, Invocation.getter(#phoneService)),
          returnValueForMissingStub:
              _FakeGooglePhoneService_2(this, Invocation.getter(#phoneService)))
      as _i4.GooglePhoneService);
  @override
  _i5.ReactiveContext get context => (super.noSuchMethod(
      Invocation.getter(#context),
      returnValue: _FakeReactiveContext_3(this, Invocation.getter(#context)),
      returnValueForMissingStub: _FakeReactiveContext_3(
          this, Invocation.getter(#context))) as _i5.ReactiveContext);
  @override
  void doneOnBoarding() =>
      super.noSuchMethod(Invocation.method(#doneOnBoarding, []),
          returnValueForMissingStub: null);
  @override
  _i7.Future<bool> isLogged() =>
      (super.noSuchMethod(Invocation.method(#isLogged, []),
              returnValue: _i7.Future<bool>.value(false),
              returnValueForMissingStub: _i7.Future<bool>.value(false))
          as _i7.Future<bool>);
  @override
  void setGoogleSignIn(bool? signedIn) =>
      super.noSuchMethod(Invocation.method(#setGoogleSignIn, [signedIn]),
          returnValueForMissingStub: null);
  @override
  void setPhoneValidation(bool? phoneValidated) => super.noSuchMethod(
      Invocation.method(#setPhoneValidation, [phoneValidated]),
      returnValueForMissingStub: null);
  @override
  _i7.Future<dynamic> setFinishLoggedIn(bool? finishedLoggedIn) =>
      (super.noSuchMethod(
              Invocation.method(#setFinishLoggedIn, [finishedLoggedIn]),
              returnValue: _i7.Future<dynamic>.value(),
              returnValueForMissingStub: _i7.Future<dynamic>.value())
          as _i7.Future<dynamic>);
  @override
  _i7.Future<void> finishLoginProcess(_i8.GoogleAuthService? googleAuth) =>
      (super.noSuchMethod(Invocation.method(#finishLoginProcess, [googleAuth]),
              returnValue: _i7.Future<void>.value(),
              returnValueForMissingStub: _i7.Future<void>.value())
          as _i7.Future<void>);
  @override
  _i7.Future<void> googleLogin() => (super.noSuchMethod(
      Invocation.method(#googleLogin, []),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
}
