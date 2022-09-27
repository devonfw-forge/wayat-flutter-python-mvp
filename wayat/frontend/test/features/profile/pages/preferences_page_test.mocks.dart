// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/profile/pages/preferences_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:ui' as _i4;

import 'package:http/http.dart' as _i6;
import 'package:image_picker/image_picker.dart' as _i12;
import 'package:mobx/mobx.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/app_state/profile_state/profile_state.dart' as _i10;
import 'package:wayat/app_state/user_session/session_state.dart' as _i7;
import 'package:wayat/domain/user/my_user.dart' as _i8;
import 'package:wayat/features/profile/controllers/profile_current_pages.dart'
    as _i11;
import 'package:wayat/lang/language.dart' as _i5;
import 'package:wayat/services/authentication/auth_service.dart' as _i2;
import 'package:wayat/services/common/http_provider/http_provider.dart' as _i13;

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

class _FakeAuthService_0 extends _i1.SmartFake implements _i2.AuthService {
  _FakeAuthService_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeReactiveContext_1 extends _i1.SmartFake
    implements _i3.ReactiveContext {
  _FakeReactiveContext_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeLocale_2 extends _i1.SmartFake implements _i4.Locale {
  _FakeLocale_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeLanguage_3 extends _i1.SmartFake implements _i5.Language {
  _FakeLanguage_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeClient_4 extends _i1.SmartFake implements _i6.Client {
  _FakeClient_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeResponse_5 extends _i1.SmartFake implements _i6.Response {
  _FakeResponse_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStreamedResponse_6 extends _i1.SmartFake
    implements _i6.StreamedResponse {
  _FakeStreamedResponse_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [SessionState].
///
/// See the documentation for Mockito's code generation for more information.
class MockSessionState extends _i1.Mock implements _i7.SessionState {
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
  set currentUser(_i8.MyUser? value) =>
      super.noSuchMethod(Invocation.setter(#currentUser, value),
          returnValueForMissingStub: null);
  @override
  _i2.AuthService get authService =>
      (super.noSuchMethod(Invocation.getter(#authService),
              returnValue:
                  _FakeAuthService_0(this, Invocation.getter(#authService)))
          as _i2.AuthService);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_1(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i9.Future<void> doneOnBoarding() => (super.noSuchMethod(
      Invocation.method(#doneOnBoarding, []),
      returnValue: _i9.Future<void>.value(),
      returnValueForMissingStub: _i9.Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<void> isLogged() => (super.noSuchMethod(
      Invocation.method(#isLogged, []),
      returnValue: _i9.Future<void>.value(),
      returnValueForMissingStub: _i9.Future<void>.value()) as _i9.Future<void>);
  @override
  void setGoogleSignIn(bool? signedIn) =>
      super.noSuchMethod(Invocation.method(#setGoogleSignIn, [signedIn]),
          returnValueForMissingStub: null);
  @override
  void setFinishLoggedIn(bool? finishedLoggedIn) => super.noSuchMethod(
      Invocation.method(#setFinishLoggedIn, [finishedLoggedIn]),
      returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> initializeUser() =>
      (super.noSuchMethod(Invocation.method(#initializeUser, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> updateCurrentUser() =>
      (super.noSuchMethod(Invocation.method(#updateCurrentUser, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<bool> updatePhone(String? phone) =>
      (super.noSuchMethod(Invocation.method(#updatePhone, [phone]),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<bool> setDoneOnBoarding() =>
      (super.noSuchMethod(Invocation.method(#setDoneOnBoarding, []),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<dynamic> doLoginProcess() =>
      (super.noSuchMethod(Invocation.method(#doLoginProcess, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> initializeUserSession() =>
      (super.noSuchMethod(Invocation.method(#initializeUserSession, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<void> login() => (super.noSuchMethod(Invocation.method(#login, []),
      returnValue: _i9.Future<void>.value(),
      returnValueForMissingStub: _i9.Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<dynamic> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  bool isOnboardingCompleted() =>
      (super.noSuchMethod(Invocation.method(#isOnboardingCompleted, []),
          returnValue: false) as bool);
  @override
  bool hasPhone() =>
      (super.noSuchMethod(Invocation.method(#hasPhone, []), returnValue: false)
          as bool);
}

/// A class which mocks [ProfileState].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileState extends _i1.Mock implements _i10.ProfileState {
  MockProfileState() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.ProfileCurrentPages get currentPage =>
      (super.noSuchMethod(Invocation.getter(#currentPage),
              returnValue: _i11.ProfileCurrentPages.editProfile)
          as _i11.ProfileCurrentPages);
  @override
  set currentPage(_i11.ProfileCurrentPages? value) =>
      super.noSuchMethod(Invocation.setter(#currentPage, value),
          returnValueForMissingStub: null);
  @override
  bool get isAccount =>
      (super.noSuchMethod(Invocation.getter(#isAccount), returnValue: false)
          as bool);
  @override
  set isAccount(bool? value) =>
      super.noSuchMethod(Invocation.setter(#isAccount, value),
          returnValueForMissingStub: null);
  @override
  set language(_i5.Language? value) =>
      super.noSuchMethod(Invocation.setter(#language, value),
          returnValueForMissingStub: null);
  @override
  set locale(_i4.Locale? value) =>
      super.noSuchMethod(Invocation.setter(#locale, value),
          returnValueForMissingStub: null);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_1(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i9.Future<_i4.Locale> initializeLocale() => (super.noSuchMethod(
          Invocation.method(#initializeLocale, []),
          returnValue: _i9.Future<_i4.Locale>.value(
              _FakeLocale_2(this, Invocation.method(#initializeLocale, []))))
      as _i9.Future<_i4.Locale>);
  @override
  _i5.Language getLanguage(String? lnguageCode) =>
      (super.noSuchMethod(Invocation.method(#getLanguage, [lnguageCode]),
              returnValue: _FakeLanguage_3(
                  this, Invocation.method(#getLanguage, [lnguageCode])))
          as _i5.Language);
  @override
  void setCurrentPage(_i11.ProfileCurrentPages? newPage) =>
      super.noSuchMethod(Invocation.method(#setCurrentPage, [newPage]),
          returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> updateCurrentUser() =>
      (super.noSuchMethod(Invocation.method(#updateCurrentUser, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> updateUserImage(_i12.XFile? newImage) =>
      (super.noSuchMethod(Invocation.method(#updateUserImage, [newImage]),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> updateCurrentUserName(String? newName) =>
      (super.noSuchMethod(Invocation.method(#updateCurrentUserName, [newName]),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  _i9.Future<dynamic> deleteCurrentUser() =>
      (super.noSuchMethod(Invocation.method(#deleteCurrentUser, []),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
  @override
  void setLocale(_i4.Locale? newLocale) =>
      super.noSuchMethod(Invocation.method(#setLocale, [newLocale]),
          returnValueForMissingStub: null);
  @override
  void setLanguage(_i5.Language? newLanguage) =>
      super.noSuchMethod(Invocation.method(#setLanguage, [newLanguage]),
          returnValueForMissingStub: null);
  @override
  _i9.Future<dynamic> changeLanguage(_i5.Language? language) =>
      (super.noSuchMethod(Invocation.method(#changeLanguage, [language]),
          returnValue: _i9.Future<dynamic>.value()) as _i9.Future<dynamic>);
}

/// A class which mocks [HttpProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpProvider extends _i1.Mock implements _i13.HttpProvider {
  MockHttpProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Client get client => (super.noSuchMethod(Invocation.getter(#client),
          returnValue: _FakeClient_4(this, Invocation.getter(#client)))
      as _i6.Client);
  @override
  String get baseUrl =>
      (super.noSuchMethod(Invocation.getter(#baseUrl), returnValue: '')
          as String);
  @override
  set baseUrl(String? _baseUrl) =>
      super.noSuchMethod(Invocation.setter(#baseUrl, _baseUrl),
          returnValueForMissingStub: null);
  @override
  _i9.Future<Map<String, String>> getHeaders() =>
      (super.noSuchMethod(Invocation.method(#getHeaders, []),
              returnValue:
                  _i9.Future<Map<String, String>>.value(<String, String>{}))
          as _i9.Future<Map<String, String>>);
  @override
  _i9.Future<Map<String, dynamic>> sendGetRequest(String? subPath) =>
      (super.noSuchMethod(Invocation.method(#sendGetRequest, [subPath]),
              returnValue:
                  _i9.Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i9.Future<Map<String, dynamic>>);
  @override
  _i9.Future<_i6.Response> sendPostRequest(
          String? subPath, Map<String, dynamic>? body) =>
      (super.noSuchMethod(Invocation.method(#sendPostRequest, [subPath, body]),
              returnValue: _i9.Future<_i6.Response>.value(_FakeResponse_5(
                  this, Invocation.method(#sendPostRequest, [subPath, body]))))
          as _i9.Future<_i6.Response>);
  @override
  _i9.Future<_i6.StreamedResponse> sendPostImageRequest(
          String? subPath, String? filePath, String? type) =>
      (super.noSuchMethod(
          Invocation.method(#sendPostImageRequest, [subPath, filePath, type]),
          returnValue: _i9.Future<_i6.StreamedResponse>.value(
              _FakeStreamedResponse_6(
                  this,
                  Invocation.method(
                      #sendPostImageRequest, [subPath, filePath, type])))) as _i9
          .Future<_i6.StreamedResponse>);
  @override
  _i9.Future<bool> sendPutRequest(
          String? subPath, Map<String, dynamic>? body) =>
      (super.noSuchMethod(Invocation.method(#sendPutRequest, [subPath, body]),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<bool> sendDelRequest(String? subPath) =>
      (super.noSuchMethod(Invocation.method(#sendDelRequest, [subPath]),
          returnValue: _i9.Future<bool>.value(false)) as _i9.Future<bool>);
}