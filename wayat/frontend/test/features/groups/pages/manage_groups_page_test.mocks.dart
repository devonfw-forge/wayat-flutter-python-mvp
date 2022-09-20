// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/groups/pages/manage_groups_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:convert' as _i16;
import 'dart:typed_data' as _i17;

import 'package:flutter/cupertino.dart' as _i5;
import 'package:image_picker/image_picker.dart' as _i11;
import 'package:mobx/mobx.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/domain/contact/contact.dart' as _i13;
import 'package:wayat/domain/group/group.dart' as _i4;
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart'
    as _i14;
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart'
    as _i7;
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart'
    as _i15;
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart'
    as _i6;
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart'
    as _i8;
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart'
    as _i9;
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart'
    as _i12;
import 'package:wayat/services/groups/groups_service.dart' as _i2;

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

class _FakeGroupsService_0 extends _i1.SmartFake implements _i2.GroupsService {
  _FakeGroupsService_0(Object parent, Invocation parentInvocation)
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

class _FakeGroup_3 extends _i1.SmartFake implements _i4.Group {
  _FakeGroup_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeTextEditingController_4 extends _i1.SmartFake
    implements _i5.TextEditingController {
  _FakeTextEditingController_4(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeRequestsController_5 extends _i1.SmartFake
    implements _i6.RequestsController {
  _FakeRequestsController_5(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeFriendsController_6 extends _i1.SmartFake
    implements _i7.FriendsController {
  _FakeFriendsController_6(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeSuggestionsController_7 extends _i1.SmartFake
    implements _i8.SuggestionsController {
  _FakeSuggestionsController_7(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeDateTime_8 extends _i1.SmartFake implements DateTime {
  _FakeDateTime_8(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeDuration_9 extends _i1.SmartFake implements Duration {
  _FakeDuration_9(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [GroupsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockGroupsController extends _i1.Mock implements _i9.GroupsController {
  MockGroupsController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GroupsService get groupsService =>
      (super.noSuchMethod(Invocation.getter(#groupsService),
              returnValue:
                  _FakeGroupsService_0(this, Invocation.getter(#groupsService)))
          as _i2.GroupsService);
  @override
  set groupsService(_i2.GroupsService? _groupsService) =>
      super.noSuchMethod(Invocation.setter(#groupsService, _groupsService),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i4.Group> get groups => (super.noSuchMethod(
      Invocation.getter(#groups),
      returnValue: _FakeObservableList_1<_i4.Group>(
          this, Invocation.getter(#groups))) as _i3.ObservableList<_i4.Group>);
  @override
  set groups(_i3.ObservableList<_i4.Group>? value) =>
      super.noSuchMethod(Invocation.setter(#groups, value),
          returnValueForMissingStub: null);
  @override
  set selectedGroup(_i4.Group? value) =>
      super.noSuchMethod(Invocation.setter(#selectedGroup, value),
          returnValueForMissingStub: null);
  @override
  bool get editGroup =>
      (super.noSuchMethod(Invocation.getter(#editGroup), returnValue: false)
          as bool);
  @override
  set editGroup(bool? value) =>
      super.noSuchMethod(Invocation.setter(#editGroup, value),
          returnValueForMissingStub: null);
  @override
  bool get updatingGroup =>
      (super.noSuchMethod(Invocation.getter(#updatingGroup), returnValue: false)
          as bool);
  @override
  set updatingGroup(bool? value) =>
      super.noSuchMethod(Invocation.setter(#updatingGroup, value),
          returnValueForMissingStub: null);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i10.Future<bool> updateGroups() =>
      (super.noSuchMethod(Invocation.method(#updateGroups, []),
          returnValue: _i10.Future<bool>.value(false)) as _i10.Future<bool>);
  @override
  void setGroups(List<_i4.Group>? groups) =>
      super.noSuchMethod(Invocation.method(#setGroups, [groups]),
          returnValueForMissingStub: null);
  @override
  _i10.Future<dynamic> createGroup(_i4.Group? group, _i11.XFile? picture) =>
      (super.noSuchMethod(Invocation.method(#createGroup, [group, picture]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  void setSelectedGroup(_i4.Group? group) =>
      super.noSuchMethod(Invocation.method(#setSelectedGroup, [group]),
          returnValueForMissingStub: null);
  @override
  void setEditGroup(bool? editValue) =>
      super.noSuchMethod(Invocation.method(#setEditGroup, [editValue]),
          returnValueForMissingStub: null);
  @override
  void setUpdatingGroup(bool? updatingGroup) =>
      super.noSuchMethod(Invocation.method(#setUpdatingGroup, [updatingGroup]),
          returnValueForMissingStub: null);
  @override
  _i10.Future<dynamic> deleteGroup(String? groupId) =>
      (super.noSuchMethod(Invocation.method(#deleteGroup, [groupId]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
}

/// A class which mocks [ManageGroupController].
///
/// See the documentation for Mockito's code generation for more information.
class MockManageGroupController extends _i1.Mock
    implements _i12.ManageGroupController {
  MockManageGroupController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Group get group => (super.noSuchMethod(Invocation.getter(#group),
      returnValue: _FakeGroup_3(this, Invocation.getter(#group))) as _i4.Group);
  @override
  set group(_i4.Group? value) =>
      super.noSuchMethod(Invocation.setter(#group, value),
          returnValueForMissingStub: null);
  @override
  bool get showValidationGroup =>
      (super.noSuchMethod(Invocation.getter(#showValidationGroup),
          returnValue: false) as bool);
  @override
  set showValidationGroup(bool? value) =>
      super.noSuchMethod(Invocation.setter(#showValidationGroup, value),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i13.Contact> get selectedContacts =>
      (super.noSuchMethod(Invocation.getter(#selectedContacts),
              returnValue: _FakeObservableList_1<_i13.Contact>(
                  this, Invocation.getter(#selectedContacts)))
          as _i3.ObservableList<_i13.Contact>);
  @override
  set selectedContacts(_i3.ObservableList<_i13.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#selectedContacts, value),
          returnValueForMissingStub: null);
  @override
  set selectedFile(_i11.XFile? value) =>
      super.noSuchMethod(Invocation.setter(#selectedFile, value),
          returnValueForMissingStub: null);
  @override
  _i5.TextEditingController get groupNameController =>
      (super.noSuchMethod(Invocation.getter(#groupNameController),
              returnValue: _FakeTextEditingController_4(
                  this, Invocation.getter(#groupNameController)))
          as _i5.TextEditingController);
  @override
  set groupNameController(_i5.TextEditingController? _groupNameController) =>
      super.noSuchMethod(
          Invocation.setter(#groupNameController, _groupNameController),
          returnValueForMissingStub: null);
  @override
  _i2.GroupsService get groupsService =>
      (super.noSuchMethod(Invocation.getter(#groupsService),
              returnValue:
                  _FakeGroupsService_0(this, Invocation.getter(#groupsService)))
          as _i2.GroupsService);
  @override
  List<_i13.Contact> get allContacts =>
      (super.noSuchMethod(Invocation.getter(#allContacts),
          returnValue: <_i13.Contact>[]) as List<_i13.Contact>);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  void addContact(_i13.Contact? contact) =>
      super.noSuchMethod(Invocation.method(#addContact, [contact]),
          returnValueForMissingStub: null);
  @override
  void removeContact(_i13.Contact? contact) =>
      super.noSuchMethod(Invocation.method(#removeContact, [contact]),
          returnValueForMissingStub: null);
  @override
  void setSelectedFile(_i11.XFile? file) =>
      super.noSuchMethod(Invocation.method(#setSelectedFile, [file]),
          returnValueForMissingStub: null);
  @override
  _i10.Future<dynamic> saveGroup() =>
      (super.noSuchMethod(Invocation.method(#saveGroup, []),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  void groupValidation() =>
      super.noSuchMethod(Invocation.method(#groupValidation, []),
          returnValueForMissingStub: null);
  @override
  _i10.Future<dynamic> getFromSource(_i11.ImageSource? source) =>
      (super.noSuchMethod(Invocation.method(#getFromSource, [source]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
}

/// A class which mocks [ContactsPageController].
///
/// See the documentation for Mockito's code generation for more information.
class MockContactsPageController extends _i1.Mock
    implements _i14.ContactsPageController {
  MockContactsPageController() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.RequestsController get requestsController =>
      (super.noSuchMethod(Invocation.getter(#requestsController),
              returnValue: _FakeRequestsController_5(
                  this, Invocation.getter(#requestsController)))
          as _i6.RequestsController);
  @override
  set requestsController(_i6.RequestsController? _requestsController) => super
      .noSuchMethod(Invocation.setter(#requestsController, _requestsController),
          returnValueForMissingStub: null);
  @override
  _i7.FriendsController get friendsController =>
      (super.noSuchMethod(Invocation.getter(#friendsController),
              returnValue: _FakeFriendsController_6(
                  this, Invocation.getter(#friendsController)))
          as _i7.FriendsController);
  @override
  set friendsController(_i7.FriendsController? _friendsController) => super
      .noSuchMethod(Invocation.setter(#friendsController, _friendsController),
          returnValueForMissingStub: null);
  @override
  _i8.SuggestionsController get suggestionsController =>
      (super.noSuchMethod(Invocation.getter(#suggestionsController),
              returnValue: _FakeSuggestionsController_7(
                  this, Invocation.getter(#suggestionsController)))
          as _i8.SuggestionsController);
  @override
  set suggestionsController(
          _i8.SuggestionsController? _suggestionsController) =>
      super.noSuchMethod(
          Invocation.setter(#suggestionsController, _suggestionsController),
          returnValueForMissingStub: null);
  @override
  DateTime get timeFriendsUpdate =>
      (super.noSuchMethod(Invocation.getter(#timeFriendsUpdate),
              returnValue:
                  _FakeDateTime_8(this, Invocation.getter(#timeFriendsUpdate)))
          as DateTime);
  @override
  set timeFriendsUpdate(DateTime? _timeFriendsUpdate) => super.noSuchMethod(
      Invocation.setter(#timeFriendsUpdate, _timeFriendsUpdate),
      returnValueForMissingStub: null);
  @override
  DateTime get timeRequestsUpdate =>
      (super.noSuchMethod(Invocation.getter(#timeRequestsUpdate),
              returnValue:
                  _FakeDateTime_8(this, Invocation.getter(#timeRequestsUpdate)))
          as DateTime);
  @override
  set timeRequestsUpdate(DateTime? _timeRequestsUpdate) => super.noSuchMethod(
      Invocation.setter(#timeRequestsUpdate, _timeRequestsUpdate),
      returnValueForMissingStub: null);
  @override
  DateTime get timeSuggestionsUpdate => (super.noSuchMethod(
          Invocation.getter(#timeSuggestionsUpdate),
          returnValue:
              _FakeDateTime_8(this, Invocation.getter(#timeSuggestionsUpdate)))
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
              _FakeDuration_9(this, Invocation.getter(#maxTimeBetweenUpdates)))
      as Duration);
  @override
  set maxTimeBetweenUpdates(Duration? _maxTimeBetweenUpdates) =>
      super.noSuchMethod(
          Invocation.setter(#maxTimeBetweenUpdates, _maxTimeBetweenUpdates),
          returnValueForMissingStub: null);
  @override
  _i15.ContactsCurrentPages get currentPage =>
      (super.noSuchMethod(Invocation.getter(#currentPage),
              returnValue: _i15.ContactsCurrentPages.contacts)
          as _i15.ContactsCurrentPages);
  @override
  set currentPage(_i15.ContactsCurrentPages? value) =>
      super.noSuchMethod(Invocation.setter(#currentPage, value),
          returnValueForMissingStub: null);
  @override
  _i5.TextEditingController get searchBarController =>
      (super.noSuchMethod(Invocation.getter(#searchBarController),
              returnValue: _FakeTextEditingController_4(
                  this, Invocation.getter(#searchBarController)))
          as _i5.TextEditingController);
  @override
  set searchBarController(_i5.TextEditingController? _searchBarController) =>
      super.noSuchMethod(
          Invocation.setter(#searchBarController, _searchBarController),
          returnValueForMissingStub: null);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  void setContactsCurrentPage(_i15.ContactsCurrentPages? currentPage) => super
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

/// A class which mocks [FriendsController].
///
/// See the documentation for Mockito's code generation for more information.
class MockFriendsController extends _i1.Mock implements _i7.FriendsController {
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
  List<_i13.Contact> get allContacts =>
      (super.noSuchMethod(Invocation.getter(#allContacts),
          returnValue: <_i13.Contact>[]) as List<_i13.Contact>);
  @override
  set allContacts(List<_i13.Contact>? _allContacts) =>
      super.noSuchMethod(Invocation.setter(#allContacts, _allContacts),
          returnValueForMissingStub: null);
  @override
  _i3.ObservableList<_i13.Contact> get filteredContacts =>
      (super.noSuchMethod(Invocation.getter(#filteredContacts),
              returnValue: _FakeObservableList_1<_i13.Contact>(
                  this, Invocation.getter(#filteredContacts)))
          as _i3.ObservableList<_i13.Contact>);
  @override
  set filteredContacts(_i3.ObservableList<_i13.Contact>? value) =>
      super.noSuchMethod(Invocation.setter(#filteredContacts, value),
          returnValueForMissingStub: null);
  @override
  List<_i13.Contact> get availableContacts =>
      (super.noSuchMethod(Invocation.getter(#availableContacts),
          returnValue: <_i13.Contact>[]) as List<_i13.Contact>);
  @override
  List<_i13.Contact> get unavailableContacts =>
      (super.noSuchMethod(Invocation.getter(#unavailableContacts),
          returnValue: <_i13.Contact>[]) as List<_i13.Contact>);
  @override
  _i3.ReactiveContext get context =>
      (super.noSuchMethod(Invocation.getter(#context),
              returnValue:
                  _FakeReactiveContext_2(this, Invocation.getter(#context)))
          as _i3.ReactiveContext);
  @override
  _i10.Future<void> updateContacts() =>
      (super.noSuchMethod(Invocation.method(#updateContacts, []),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  void setTextFilter(String? text) =>
      super.noSuchMethod(Invocation.method(#setTextFilter, [text]),
          returnValueForMissingStub: null);
  @override
  _i10.Future<void> removeContact(_i13.Contact? contact) =>
      (super.noSuchMethod(Invocation.method(#removeContact, [contact]),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  void addContact(_i13.Contact? contact) =>
      super.noSuchMethod(Invocation.method(#addContact, [contact]),
          returnValueForMissingStub: null);
}

/// A class which mocks [XFile].
///
/// See the documentation for Mockito's code generation for more information.
class MockXFile extends _i1.Mock implements _i11.XFile {
  MockXFile() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  _i10.Future<void> saveTo(String? path) =>
      (super.noSuchMethod(Invocation.method(#saveTo, [path]),
              returnValue: _i10.Future<void>.value(),
              returnValueForMissingStub: _i10.Future<void>.value())
          as _i10.Future<void>);
  @override
  _i10.Future<int> length() =>
      (super.noSuchMethod(Invocation.method(#length, []),
          returnValue: _i10.Future<int>.value(0)) as _i10.Future<int>);
  @override
  _i10.Future<String> readAsString(
          {_i16.Encoding? encoding = const _i16.Utf8Codec()}) =>
      (super.noSuchMethod(
          Invocation.method(#readAsString, [], {#encoding: encoding}),
          returnValue: _i10.Future<String>.value('')) as _i10.Future<String>);
  @override
  _i10.Future<_i17.Uint8List> readAsBytes() =>
      (super.noSuchMethod(Invocation.method(#readAsBytes, []),
              returnValue: _i10.Future<_i17.Uint8List>.value(_i17.Uint8List(0)))
          as _i10.Future<_i17.Uint8List>);
  @override
  _i10.Stream<_i17.Uint8List> openRead([int? start, int? end]) =>
      (super.noSuchMethod(Invocation.method(#openRead, [start, end]),
              returnValue: _i10.Stream<_i17.Uint8List>.empty())
          as _i10.Stream<_i17.Uint8List>);
  @override
  _i10.Future<DateTime> lastModified() =>
      (super.noSuchMethod(Invocation.method(#lastModified, []),
              returnValue: _i10.Future<DateTime>.value(
                  _FakeDateTime_8(this, Invocation.method(#lastModified, []))))
          as _i10.Future<DateTime>);
}

/// A class which mocks [GroupsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGroupsService extends _i1.Mock implements _i2.GroupsService {
  MockGroupsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<List<_i4.Group>> getAll() =>
      (super.noSuchMethod(Invocation.method(#getAll, []),
              returnValue: _i10.Future<List<_i4.Group>>.value(<_i4.Group>[]))
          as _i10.Future<List<_i4.Group>>);
  @override
  _i10.Future<dynamic> create(_i4.Group? group, _i11.XFile? picture) =>
      (super.noSuchMethod(Invocation.method(#create, [group, picture]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<dynamic> update(_i4.Group? group, _i11.XFile? picture) =>
      (super.noSuchMethod(Invocation.method(#update, [group, picture]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
  @override
  _i10.Future<dynamic> delete(String? groupId) =>
      (super.noSuchMethod(Invocation.method(#delete, [groupId]),
          returnValue: _i10.Future<dynamic>.value()) as _i10.Future<dynamic>);
}
