// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/onboarding/controller/onboarding_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:mobx/mobx.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/app_state/user_session/session_state.dart' as _i12;
import 'package:wayat/domain/contact/contact.dart' as _i9;
import 'package:wayat/domain/user/my_user.dart' as _i13;
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart'
    as _i6;
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart'
    as _i8;
import 'package:wayat/features/onboarding/controller/onboarding_state.dart'
    as _i7;
import 'package:wayat/services/authentication/auth_service.dart' as _i5;
import 'package:wayat/services/contact/contact_service.dart' as _i3;
import 'package:wayat/services/contact/flutter_contacts_handler_libw.dart'
    as _i11;
import 'package:wayat/services/contact/import_phones_service_impl.dart' as _i2;

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

class _FakeContactsAddressServiceImpl_0 extends _i1.SmartFake
    implements _i2.ContactsAddressServiceImpl {
  _FakeContactsAddressServiceImpl_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeContactService_1 extends _i1.SmartFake
    implements _i3.ContactService {
  _FakeContactService_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeObservableMap_2<K, V> extends _i1.SmartFake
    implements _i4.ObservableMap<K, V> {
  _FakeObservableMap_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeReactiveContext_3 extends _i1.SmartFake
    implements _i4.ReactiveContext {
  _FakeReactiveContext_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeAuthService_4 extends _i1.SmartFake implements _i5.AuthService {
  _FakeAuthService_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [OnboardingController].
///
/// See the documentation for Mockito's code generation for more information.
class MockOnboardingController extends _i1.Mock
    implements _i6.OnboardingController {
  MockOnboardingController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ContactsAddressServiceImpl get importContactService =>
      (super.noSuchMethod(Invocation.getter(#importContactService),
              returnValue: _FakeContactsAddressServiceImpl_0(
                  this, Invocation.getter(#importContactService)))
          as _i2.ContactsAddressServiceImpl);
  @override
  _i3.ContactService get contactService => (super.noSuchMethod(
          Invocation.getter(#contactService),
          returnValue:
              _FakeContactService_1(this, Invocation.getter(#contactService)))
      as _i3.ContactService);
  @override
  _i7.OnBoardingState get onBoardingState =>
      (super.noSuchMethod(Invocation.getter(#onBoardingState),
          returnValue: _i7.OnBoardingState.notStarted) as _i7.OnBoardingState);
  @override
  set onBoardingState(_i7.OnBoardingState? value) =>
      super.noSuchMethod(Invocation.setter(#onBoardingState, value),
          returnValueForMissingStub: null);
  @override
  _i8.OnBoardingProgress get currentPage =>
      (super.noSuchMethod(Invocation.getter(#currentPage),
              returnValue: _i8.OnBoardingProgress.initialManageContactsTip)
          as _i8.OnBoardingProgress);
  @override
  set currentPage(_i8.OnBoardingProgress? value) =>
      super.noSuchMethod(Invocation.setter(#currentPage, value),
          returnValueForMissingStub: null);
  @override
  _i4.ObservableMap<_i9.Contact, bool> get contacts =>
      (super.noSuchMethod(Invocation.getter(#contacts),
              returnValue: _FakeObservableMap_2<_i9.Contact, bool>(
                  this, Invocation.getter(#contacts)))
          as _i4.ObservableMap<_i9.Contact, bool>);
  @override
  set contacts(_i4.ObservableMap<_i9.Contact, bool>? value) =>
      super.noSuchMethod(Invocation.setter(#contacts, value),
          returnValueForMissingStub: null);
  @override
  List<_i9.Contact> get contactList =>
      (super.noSuchMethod(Invocation.getter(#contactList),
          returnValue: <_i9.Contact>[]) as List<_i9.Contact>);
  @override
  List<_i9.Contact> get selectedContacts =>
      (super.noSuchMethod(Invocation.getter(#selectedContacts),
          returnValue: <_i9.Contact>[]) as List<_i9.Contact>);
  @override
  List<_i9.Contact> get unselectedContacts =>
      (super.noSuchMethod(Invocation.getter(#unselectedContacts),
          returnValue: <_i9.Contact>[]) as List<_i9.Contact>);
  @override
  _i4.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_3(this, Invocation.getter(#context)))
          as _i4.ReactiveContext);
  @override
  void importContacts() =>
      super.noSuchMethod(Invocation.method(#importContacts, []),
          returnValueForMissingStub: null);
  @override
  bool isSelected(_i9.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#isSelected, [contact]),
          returnValue: false) as bool);
  @override
  void finishOnBoarding() =>
      super.noSuchMethod(Invocation.method(#finishOnBoarding, []),
          returnValueForMissingStub: null);
  @override
  void progressTo(_i8.OnBoardingProgress? newPage) =>
      super.noSuchMethod(Invocation.method(#progressTo, [newPage]),
          returnValueForMissingStub: null);
  @override
  bool moveBack() =>
      (super.noSuchMethod(Invocation.method(#moveBack, []), returnValue: false)
          as bool);
  @override
  void updateSelected(_i9.Contact? contact) =>
      super.noSuchMethod(Invocation.method(#updateSelected, [contact]),
          returnValueForMissingStub: null);
  @override
  void addAll(List<_i9.Contact>? contactList) =>
      super.noSuchMethod(Invocation.method(#addAll, [contactList]),
          returnValueForMissingStub: null);
  @override
  void setOnBoardingState(_i7.OnBoardingState? state) =>
      super.noSuchMethod(Invocation.method(#setOnBoardingState, [state]),
          returnValueForMissingStub: null);
}

/// A class which mocks [ContactsAddressServiceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactsAddressServiceImpl extends _i1.Mock
    implements _i2.ContactsAddressServiceImpl {
  MockContactsAddressServiceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<List<String>> getAllPhones(
          {_i11.FlutterContactsHandlerLibW? handler}) =>
      (super.noSuchMethod(
              Invocation.method(#getAllPhones, [], {#handler: handler}),
              returnValue: _i10.Future<List<String>>.value(<String>[]))
          as _i10.Future<List<String>>);
}

/// A class which mocks [ContactService].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactService extends _i1.Mock implements _i3.ContactService {
  MockContactService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<List<_i9.Contact>> getAll() => (super.noSuchMethod(
          Invocation.method(#getAll, []),
          returnValue: _i10.Future<List<_i9.Contact>>.value(<_i9.Contact>[]))
      as _i10.Future<List<_i9.Contact>>);
  @override
  _i10.Future<void> sendRequests(List<_i9.Contact>? contacts) =>
      (super.noSuchMethod(Invocation.method(#sendRequests, [contacts]),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  _i10.Future<List<_i9.Contact>> getFilteredContacts(
          List<String>? importedContacts) =>
      (super.noSuchMethod(
              Invocation.method(#getFilteredContacts, [importedContacts]),
              returnValue:
                  _i10.Future<List<_i9.Contact>>.value(<_i9.Contact>[]))
          as _i10.Future<List<_i9.Contact>>);
  @override
  _i10.Future<bool> removeContact(_i9.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#removeContact, [contact]),
          returnValue: _i10.Future<bool>.value(false)) as _i10.Future<bool>);
}

/// A class which mocks [SessionState].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionState extends _i1.Mock implements _i12.SessionState {
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
  bool get hasDoneOnboarding =>
      (super.noSuchMethod(Invocation.getter(#hasDoneOnboarding),
          returnValue: false) as bool);
  @override
  set hasDoneOnboarding(bool? value) =>
      super.noSuchMethod(Invocation.setter(#hasDoneOnboarding, value),
          returnValueForMissingStub: null);
  @override
  set currentUser(_i13.MyUser? value) =>
      super.noSuchMethod(Invocation.setter(#currentUser, value),
          returnValueForMissingStub: null);
  @override
  _i5.AuthService get authService =>
      (super.noSuchMethod(Invocation.getter(#authService),
              returnValue:
                  _FakeAuthService_4(this, Invocation.getter(#authService)))
          as _i5.AuthService);
  @override
  _i4.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_3(this, Invocation.getter(#context)))
          as _i4.ReactiveContext);
  @override
  _i10.Future<void> doneOnBoarding() =>
      (super.noSuchMethod(Invocation.method(#doneOnBoarding, []),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  _i10.Future<void> isLogged() =>
      (super.noSuchMethod(Invocation.method(#isLogged, []),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  void setGoogleSignIn(bool? signedIn) =>
      super.noSuchMethod(Invocation.method(#setGoogleSignIn, [signedIn]),
          returnValueForMissingStub: null);
  @override
  void setFinishLoggedIn(bool? finishedLoggedIn) => super.noSuchMethod(
      Invocation.method(#setFinishLoggedIn, [finishedLoggedIn]),
      returnValueForMissingStub: null);
  @override
  _i10.Future<dynamic> initializeUser() =>
      (super.noSuchMethod(Invocation.method(#initializeUser, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<dynamic> updateCurrentUser() =>
      (super.noSuchMethod(Invocation.method(#updateCurrentUser, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<bool> updatePhone(String? phone) =>
      (super.noSuchMethod(Invocation.method(#updatePhone, [phone]),
          returnValue: _i10.Future<bool>.value(false)) as _i10.Future<bool>);
  @override
  _i10.Future<bool> setDoneOnBoarding() =>
      (super.noSuchMethod(Invocation.method(#setDoneOnBoarding, []),
          returnValue: _i10.Future<bool>.value(false)) as _i10.Future<bool>);
  @override
  _i10.Future<dynamic> doLoginProcess() =>
      (super.noSuchMethod(Invocation.method(#doLoginProcess, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<dynamic> initializeUserSession() =>
      (super.noSuchMethod(Invocation.method(#initializeUserSession, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<void> login() =>
      (super.noSuchMethod(Invocation.method(#login, []),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  _i10.Future<dynamic> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  bool isOnboardingCompleted() =>
      (super.noSuchMethod(Invocation.method(#isOnboardingCompleted, []),
          returnValue: false) as bool);
  @override
  bool hasPhone() =>
      (super.noSuchMethod(Invocation.method(#hasPhone, []), returnValue: false)
          as bool);
}
