// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/contacts/pages/contacts_page/suggestions_page/suggestions_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:flutter/material.dart' as _i5;
import 'package:mobx/mobx.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/domain/contact/contact.dart' as _i10;
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart'
    as _i8;
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart'
    as _i3;
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart'
    as _i9;
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart'
    as _i2;
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart'
    as _i4;
import 'package:wayat/services/contact/contact_service.dart' as _i7;

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

class _FakeRequestsController_0 extends _i1.SmartFake
    implements _i2.RequestsController {
  _FakeRequestsController_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeFriendsController_1 extends _i1.SmartFake
    implements _i3.FriendsController {
  _FakeFriendsController_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSuggestionsController_2 extends _i1.SmartFake
    implements _i4.SuggestionsController {
  _FakeSuggestionsController_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeDateTime_3 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeDuration_4 extends _i1.SmartFake implements Duration {
  _FakeDuration_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTextEditingController_5 extends _i1.SmartFake
    implements _i5.TextEditingController {
  _FakeTextEditingController_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeReactiveContext_6 extends _i1.SmartFake
    implements _i6.ReactiveContext {
  _FakeReactiveContext_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeContactService_7 extends _i1.SmartFake
    implements _i7.ContactService {
  _FakeContactService_7(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeObservableList_8<T> extends _i1.SmartFake
    implements _i6.ObservableList<T> {
  _FakeObservableList_8(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [ContactsPageController].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactsPageController extends _i1.Mock
    implements _i8.ContactsPageController {
  MockContactsPageController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RequestsController get requestsController =>
      (super.noSuchMethod(Invocation.getter(#requestsController),
              returnValue: _FakeRequestsController_0(
                  this, Invocation.getter(#requestsController)))
          as _i2.RequestsController);
  @override
  set requestsController(_i2.RequestsController? _requestsController) => super
      .noSuchMethod(Invocation.setter(#requestsController, _requestsController),
          returnValueForMissingStub: null);
  @override
  _i3.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_1(
                  this, Invocation.getter(#friendsController)))
          as _i3.FriendsController);
  @override
  _i4.SuggestionsController get suggestionsController =>
      (super.noSuchMethod(Invocation.getter(#suggestionsController),
              returnValue: _FakeSuggestionsController_2(
                  this, Invocation.getter(#suggestionsController)))
          as _i4.SuggestionsController);
  @override
  set suggestionsController(
          _i4.SuggestionsController? _suggestionsController) =>
      super.noSuchMethod(
          Invocation.setter(#suggestionsController, _suggestionsController),
          returnValueForMissingStub: null);
  @override
  DateTime get timeFriendsUpdate =>
      (super.noSuchMethod(Invocation.getter(#timeFriendsUpdate),
              returnValue:
                  _FakeDateTime_3(this, Invocation.getter(#timeFriendsUpdate)))
          as DateTime);
  @override
  set timeFriendsUpdate(DateTime? _timeFriendsUpdate) => super.noSuchMethod(
      Invocation.setter(#timeFriendsUpdate, _timeFriendsUpdate),
      returnValueForMissingStub: null);
  @override
  DateTime get timeRequestsUpdate =>
      (super.noSuchMethod(Invocation.getter(#timeRequestsUpdate),
              returnValue:
                  _FakeDateTime_3(this, Invocation.getter(#timeRequestsUpdate)))
          as DateTime);
  @override
  set timeRequestsUpdate(DateTime? _timeRequestsUpdate) => super.noSuchMethod(
      Invocation.setter(#timeRequestsUpdate, _timeRequestsUpdate),
      returnValueForMissingStub: null);
  @override
  DateTime get timeSuggestionsUpdate => (super.noSuchMethod(
          Invocation.getter(#timeSuggestionsUpdate),
          returnValue:
              _FakeDateTime_3(this, Invocation.getter(#timeSuggestionsUpdate)))
      as DateTime);
  @override
  set timeSuggestionsUpdate(DateTime? _timeSuggestionsUpdate) =>
      super.noSuchMethod(
          Invocation.setter(#timeSuggestionsUpdate, _timeSuggestionsUpdate),
          returnValueForMissingStub: null);
  @override
  Duration get maxTimeBetweenUpdates => (super.noSuchMethod(
          Invocation.getter(#maxTimeBetweenUpdates),
          returnValue:
              _FakeDuration_4(this, Invocation.getter(#maxTimeBetweenUpdates)))
      as Duration);
  @override
  set maxTimeBetweenUpdates(Duration? _maxTimeBetweenUpdates) =>
      super.noSuchMethod(
          Invocation.setter(#maxTimeBetweenUpdates, _maxTimeBetweenUpdates),
          returnValueForMissingStub: null);
  @override
  _i9.ContactsCurrentPages get currentPage =>
      (super.noSuchMethod(Invocation.getter(#currentPage),
              returnValue: _i9.ContactsCurrentPages.contacts)
          as _i9.ContactsCurrentPages);
  @override
  set currentPage(_i9.ContactsCurrentPages? value) =>
      super.noSuchMethod(Invocation.setter(#currentPage, value),
          returnValueForMissingStub: null);
  @override
  _i5.TextEditingController get searchBarController =>
      (super.noSuchMethod(Invocation.getter(#searchBarController),
              returnValue: _FakeTextEditingController_5(
                  this, Invocation.getter(#searchBarController)))
          as _i5.TextEditingController);
  @override
  set searchBarController(_i5.TextEditingController? _searchBarController) =>
      super.noSuchMethod(
          Invocation.setter(#searchBarController, _searchBarController),
          returnValueForMissingStub: null);
  @override
  _i6.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_6(this, Invocation.getter(#context)))
          as _i6.ReactiveContext);
  @override
  void setContactsCurrentPage(_i9.ContactsCurrentPages? currentPage) => super
      .noSuchMethod(Invocation.method(#setContactsCurrentPage, [currentPage]),
          returnValueForMissingStub: null);
  @override
  void setSearchBarText(String? text) =>
      super.noSuchMethod(Invocation.method(#setSearchBarText, [text]),
          returnValueForMissingStub: null);
  @override
  void updateTabData(int? index) =>
      super.noSuchMethod(Invocation.method(#updateTabData, [index]),
          returnValueForMissingStub: null);
}

/// A class which mocks [SuggestionsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockSuggestionsController extends _i1.Mock
    implements _i4.SuggestionsController {
  MockSuggestionsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.ContactService get contactsService => (super.noSuchMethod(
          Invocation.getter(#contactsService),
          returnValue:
              _FakeContactService_7(this, Invocation.getter(#contactsService)))
      as _i7.ContactService);
  @override
  _i3.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_1(
                  this, Invocation.getter(#friendsController)))
          as _i3.FriendsController);
  @override
  _i2.RequestsController get requestsController =>
      (super.noSuchMethod(Invocation.getter(#requestsController),
              returnValue: _FakeRequestsController_0(
                  this, Invocation.getter(#requestsController)))
          as _i2.RequestsController);
  @override
  String get textFilter =>
      (super.noSuchMethod(Invocation.getter(#textFilter), returnValue: '')
          as String);
  @override
  set textFilter(String? _textFilter) =>
      super.noSuchMethod(Invocation.setter(#textFilter, _textFilter),
          returnValueForMissingStub: null);
  @override
  List<_i10.Contact> get allSuggestions =>
      (super.noSuchMethod(Invocation.getter(#allSuggestions),
          returnValue: <_i10.Contact>[]) as List<_i10.Contact>);
  @override
  set allSuggestions(List<_i10.Contact>? _allSuggestions) =>
      super.noSuchMethod(Invocation.setter(#allSuggestions, _allSuggestions),
          returnValueForMissingStub: null);
  @override
  _i6.ObservableList<_i10.Contact> get filteredSuggestions =>
      (super.noSuchMethod(Invocation.getter(#filteredSuggestions),
              returnValue: _FakeObservableList_8<_i10.Contact>(
                  this, Invocation.getter(#filteredSuggestions)))
          as _i6.ObservableList<_i10.Contact>);
  @override
  set filteredSuggestions(_i6.ObservableList<_i10.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredSuggestions, value),
          returnValueForMissingStub: null);
  @override
  _i6.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_6(this, Invocation.getter(#context)))
          as _i6.ReactiveContext);
  @override
  _i11.Future<void> sendRequest(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#sendRequest, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<dynamic> updateSuggestedContacts() =>
      (super.noSuchMethod(Invocation.method(#updateSuggestedContacts, []),
          returnValue: _i11.Future<dynamic>.value()) as _i11.Future<dynamic>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
  @override
  _i11.Future<dynamic> copyInvitation() =>
      (super.noSuchMethod(Invocation.method(#copyInvitation, []),
          returnValue: _i11.Future<dynamic>.value()) as _i11.Future<dynamic>);
  @override
  String platformText() =>
      (super.noSuchMethod(Invocation.method(#platformText, []), returnValue: '')
          as String);
}

/// A class which mocks [ContactService].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactService extends _i1.Mock implements _i7.ContactService {
  MockContactService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i11.Future<List<_i10.Contact>> getAll() => (super.noSuchMethod(
          Invocation.method(#getAll, []),
          returnValue: _i11.Future<List<_i10.Contact>>.value(<_i10.Contact>[]))
      as _i11.Future<List<_i10.Contact>>);
  @override
  _i11.Future<void> sendRequests(List<_i10.Contact>? contacts) =>
      (super.noSuchMethod(Invocation.method(#sendRequests, [contacts]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<List<_i10.Contact>> getFilteredContacts(
          List<String>? importedContacts) =>
      (super.noSuchMethod(
              Invocation.method(#getFilteredContacts, [importedContacts]),
              returnValue:
                  _i11.Future<List<_i10.Contact>>.value(<_i10.Contact>[]))
          as _i11.Future<List<_i10.Contact>>);
  @override
  _i11.Future<bool> removeContact(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#removeContact, [contact]),
          returnValue: _i11.Future<bool>.value(false)) as _i11.Future<bool>);
}

/// A class which mocks [FriendsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockFriendsController extends _i1.Mock implements _i3.FriendsController {
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
  List<_i10.Contact> get allContacts =>
      (super.noSuchMethod(Invocation.getter(#allContacts),
          returnValue: <_i10.Contact>[]) as List<_i10.Contact>);
  @override
  set allContacts(List<_i10.Contact>? _allContacts) =>
      super.noSuchMethod(Invocation.setter(#allContacts, _allContacts),
          returnValueForMissingStub: null);
  @override
  _i6.ObservableList<_i10.Contact> get filteredContacts =>
      (super.noSuchMethod(Invocation.getter(#filteredContacts),
              returnValue: _FakeObservableList_8<_i10.Contact>(
                  this, Invocation.getter(#filteredContacts)))
          as _i6.ObservableList<_i10.Contact>);
  @override
  set filteredContacts(_i6.ObservableList<_i10.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredContacts, value),
          returnValueForMissingStub: null);
  @override
  List<_i10.Contact> get availableContacts =>
      (super.noSuchMethod(Invocation.getter(#availableContacts),
          returnValue: <_i10.Contact>[]) as List<_i10.Contact>);
  @override
  List<_i10.Contact> get unavailableContacts =>
      (super.noSuchMethod(Invocation.getter(#unavailableContacts),
          returnValue: <_i10.Contact>[]) as List<_i10.Contact>);
  @override
  _i6.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_6(this, Invocation.getter(#context)))
          as _i6.ReactiveContext);
  @override
  _i11.Future<void> updateContacts() =>
      (super.noSuchMethod(Invocation.method(#updateContacts, []),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
  @override
  _i11.Future<void> removeContact(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#removeContact, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
}

/// A class which mocks [RequestsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockRequestsController extends _i1.Mock
    implements _i2.RequestsController {
  MockRequestsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_1(
                  this, Invocation.getter(#friendsController)))
          as _i3.FriendsController);
  @override
  String get textFilter =>
      (super.noSuchMethod(Invocation.getter(#textFilter), returnValue: '')
          as String);
  @override
  set textFilter(String? _textFilter) =>
      super.noSuchMethod(Invocation.setter(#textFilter, _textFilter),
          returnValueForMissingStub: null);
  @override
  _i6.ObservableList<_i10.Contact> get filteredPendingRequests =>
      (super.noSuchMethod(Invocation.getter(#filteredPendingRequests),
              returnValue: _FakeObservableList_8<_i10.Contact>(
                  this, Invocation.getter(#filteredPendingRequests)))
          as _i6.ObservableList<_i10.Contact>);
  @override
  set filteredPendingRequests(_i6.ObservableList<_i10.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredPendingRequests, value),
          returnValueForMissingStub: null);
  @override
  _i6.ObservableList<_i10.Contact> get pendingRequests =>
      (super.noSuchMethod(Invocation.getter(#pendingRequests),
              returnValue: _FakeObservableList_8<_i10.Contact>(
                  this, Invocation.getter(#pendingRequests)))
          as _i6.ObservableList<_i10.Contact>);
  @override
  set pendingRequests(_i6.ObservableList<_i10.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#pendingRequests, value),
          returnValueForMissingStub: null);
  @override
  _i6.ObservableList<_i10.Contact> get sentRequests =>
      (super.noSuchMethod(Invocation.getter(#sentRequests),
              returnValue: _FakeObservableList_8<_i10.Contact>(
                  this, Invocation.getter(#sentRequests)))
          as _i6.ObservableList<_i10.Contact>);
  @override
  set sentRequests(_i6.ObservableList<_i10.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#sentRequests, value),
          returnValueForMissingStub: null);
  @override
  _i6.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_6(this, Invocation.getter(#context)))
          as _i6.ReactiveContext);
  @override
  _i11.Future<void> updateRequests() =>
      (super.noSuchMethod(Invocation.method(#updateRequests, []),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> sendRequest(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#sendRequest, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> rejectRequest(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#rejectRequest, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> acceptRequest(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#acceptRequest, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  _i11.Future<void> unsendRequest(_i10.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#unsendRequest, [contact]),
              returnValue: _i11.Future<void>.value(),
              returnValueForMissingStub: _i11.Future<void>.value())
          as _i11.Future<void>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
}
