// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/contacts/controller/contacts_page_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:mobx/mobx.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/domain/contact/contact.dart' as _i6;
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart'
    as _i2;
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart'
    as _i5;
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart'
    as _i8;
import 'package:wayat/services/contact/contact_service.dart' as _i4;

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

class _FakeFriendsController_0 extends _i1.SmartFake
    implements _i2.FriendsController {
  _FakeFriendsController_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeObservableList_1<T> extends _i1.SmartFake
    implements _i3.ObservableList<T> {
  _FakeObservableList_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeReactiveContext_2 extends _i1.SmartFake
    implements _i3.ReactiveContext {
  _FakeReactiveContext_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeContactService_3 extends _i1.SmartFake
    implements _i4.ContactService {
  _FakeContactService_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRequestsController_4 extends _i1.SmartFake
    implements _i5.RequestsController {
  _FakeRequestsController_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [RequestsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequestsController extends _i1.Mock
    implements _i5.RequestsController {
  MockRequestsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_0(
                  this, Invocation.getter(#friendsController)))
          as _i2.FriendsController);
  @override
  String get textFilter =>
      (super.noSuchMethod(Invocation.getter(#textFilter), returnValue: '')
          as String);
  @override
  set textFilter(String? _textFilter) =>
      super.noSuchMethod(Invocation.setter(#textFilter, _textFilter),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i6.Contact> get filteredPendingRequests =>
      (super.noSuchMethod(Invocation.getter(#filteredPendingRequests),
              returnValue: _FakeObservableList_1<_i6.Contact>(
                  this, Invocation.getter(#filteredPendingRequests)))
          as _i3.ObservableList<_i6.Contact>);
  @override
  set filteredPendingRequests(_i3.ObservableList<_i6.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredPendingRequests, value),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i6.Contact> get pendingRequests =>
      (super.noSuchMethod(Invocation.getter(#pendingRequests),
              returnValue: _FakeObservableList_1<_i6.Contact>(
                  this, Invocation.getter(#pendingRequests)))
          as _i3.ObservableList<_i6.Contact>);
  @override
  set pendingRequests(_i3.ObservableList<_i6.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#pendingRequests, value),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i6.Contact> get sentRequests =>
      (super.noSuchMethod(Invocation.getter(#sentRequests),
              returnValue: _FakeObservableList_1<_i6.Contact>(
                  this, Invocation.getter(#sentRequests)))
          as _i3.ObservableList<_i6.Contact>);
  @override
  set sentRequests(_i3.ObservableList<_i6.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#sentRequests, value),
          returnValueForMissingStub: null);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i7.Future<void> updateRequests() => (super.noSuchMethod(
      Invocation.method(#updateRequests, []),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> sendRequest(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#sendRequest, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> rejectRequest(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#rejectRequest, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> acceptRequest(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#acceptRequest, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<void> unsendRequest(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#unsendRequest, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
}

/// A class which mocks [FriendsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockFriendsController extends _i1.Mock implements _i2.FriendsController {
  MockFriendsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get textFilter =>
      (super.noSuchMethod(Invocation.getter(#textFilter), returnValue: '')
          as String);
  @override
  set textFilter(String? _textFilter) =>
      super.noSuchMethod(Invocation.setter(#textFilter, _textFilter),
          returnValueForMissingStub: null);
  @override
  List<_i6.Contact> get allContacts =>
      (super.noSuchMethod(Invocation.getter(#allContacts),
          returnValue: <_i6.Contact>[]) as List<_i6.Contact>);
  @override
  set allContacts(List<_i6.Contact>? _allContacts) =>
      super.noSuchMethod(Invocation.setter(#allContacts, _allContacts),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i6.Contact> get filteredContacts =>
      (super.noSuchMethod(Invocation.getter(#filteredContacts),
              returnValue: _FakeObservableList_1<_i6.Contact>(
                  this, Invocation.getter(#filteredContacts)))
          as _i3.ObservableList<_i6.Contact>);
  @override
  set filteredContacts(_i3.ObservableList<_i6.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredContacts, value),
          returnValueForMissingStub: null);
  @override
  List<_i6.Contact> get availableContacts =>
      (super.noSuchMethod(Invocation.getter(#availableContacts),
          returnValue: <_i6.Contact>[]) as List<_i6.Contact>);
  @override
  List<_i6.Contact> get unavailableContacts =>
      (super.noSuchMethod(Invocation.getter(#unavailableContacts),
          returnValue: <_i6.Contact>[]) as List<_i6.Contact>);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i7.Future<void> updateContacts() => (super.noSuchMethod(
      Invocation.method(#updateContacts, []),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<void> removeContact(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#removeContact, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
}

/// A class which mocks [SuggestionsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockSuggestionsController extends _i1.Mock
    implements _i8.SuggestionsController {
  MockSuggestionsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.ContactService get contactsService => (super.noSuchMethod(
          Invocation.getter(#contactsService),
          returnValue:
              _FakeContactService_3(this, Invocation.getter(#contactsService)))
      as _i4.ContactService);
  @override
  _i2.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_0(
                  this, Invocation.getter(#friendsController)))
          as _i2.FriendsController);
  @override
  _i5.RequestsController get requestsController =>
      (super.noSuchMethod(Invocation.getter(#requestsController),
              returnValue: _FakeRequestsController_4(
                  this, Invocation.getter(#requestsController)))
          as _i5.RequestsController);
  @override
  String get textFilter =>
      (super.noSuchMethod(Invocation.getter(#textFilter), returnValue: '')
          as String);
  @override
  set textFilter(String? _textFilter) =>
      super.noSuchMethod(Invocation.setter(#textFilter, _textFilter),
          returnValueForMissingStub: null);
  @override
  List<_i6.Contact> get allSuggestions =>
      (super.noSuchMethod(Invocation.getter(#allSuggestions),
          returnValue: <_i6.Contact>[]) as List<_i6.Contact>);
  @override
  set allSuggestions(List<_i6.Contact>? _allSuggestions) =>
      super.noSuchMethod(Invocation.setter(#allSuggestions, _allSuggestions),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i6.Contact> get filteredSuggestions =>
      (super.noSuchMethod(Invocation.getter(#filteredSuggestions),
              returnValue: _FakeObservableList_1<_i6.Contact>(
                  this, Invocation.getter(#filteredSuggestions)))
          as _i3.ObservableList<_i6.Contact>);
  @override
  set filteredSuggestions(_i3.ObservableList<_i6.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredSuggestions, value),
          returnValueForMissingStub: null);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i7.Future<void> sendRequest(_i6.Contact? contact) => (super.noSuchMethod(
      Invocation.method(#sendRequest, [contact]),
      returnValue: _i7.Future<void>.value(),
      returnValueForMissingStub: _i7.Future<void>.value()) as _i7.Future<void>);
  @override
  _i7.Future<dynamic> updateSuggestedContacts() =>
      (super.noSuchMethod(Invocation.method(#updateSuggestedContacts, []),
          returnValue: _i7.Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<dynamic> copyInvitation() =>
      (super.noSuchMethod(Invocation.method(#copyInvitation, []),
          returnValue: _i7.Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  String platformText() =>
      (super.noSuchMethod(Invocation.method(#platformText, []), returnValue: '')
          as String);
}
