// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingController on _OnboardingController, Store {
  Computed<List<Contact>>? _$contactListComputed;

  @override
  List<Contact> get contactList => (_$contactListComputed ??=
          Computed<List<Contact>>(() => super.contactList,
              name: '_OnboardingController.contactList'))
      .value;
  Computed<List<Contact>>? _$selectedContactsComputed;

  @override
  List<Contact> get selectedContacts => (_$selectedContactsComputed ??=
          Computed<List<Contact>>(() => super.selectedContacts,
              name: '_OnboardingController.selectedContacts'))
      .value;
  Computed<List<Contact>>? _$unselectedContactsComputed;

  @override
  List<Contact> get unselectedContacts => (_$unselectedContactsComputed ??=
          Computed<List<Contact>>(() => super.unselectedContacts,
              name: '_OnboardingController.unselectedContacts'))
      .value;

  late final _$onBoardingStateAtom =
      Atom(name: '_OnboardingController.onBoardingState', context: context);

  @override
  OnBoardingState get onBoardingState {
    _$onBoardingStateAtom.reportRead();
    return super.onBoardingState;
  }

  @override
  set onBoardingState(OnBoardingState value) {
    _$onBoardingStateAtom.reportWrite(value, super.onBoardingState, () {
      super.onBoardingState = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_OnboardingController.currentPage', context: context);

  @override
  OnBoardingProgress get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(OnBoardingProgress value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$contactsAtom =
      Atom(name: '_OnboardingController.contacts', context: context);

  @override
  ObservableMap<Contact, bool> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableMap<Contact, bool> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$_OnboardingControllerActionController =
      ActionController(name: '_OnboardingController', context: context);

  @override
  void progressTo(OnBoardingProgress newPage) {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.progressTo');
    try {
      return super.progressTo(newPage);
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool moveBack() {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.moveBack');
    try {
      return super.moveBack();
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSelected(Contact contact) {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.updateSelected');
    try {
      return super.updateSelected(contact);
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAll(List<Contact> contactList) {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.addAll');
    try {
      return super.addAll(contactList);
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnBoardingState(OnBoardingState state) {
    final _$actionInfo = _$_OnboardingControllerActionController.startAction(
        name: '_OnboardingController.setOnBoardingState');
    try {
      return super.setOnBoardingState(state);
    } finally {
      _$_OnboardingControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
onBoardingState: ${onBoardingState},
currentPage: ${currentPage},
contacts: ${contacts},
contactList: ${contactList},
selectedContacts: ${selectedContacts},
unselectedContacts: ${unselectedContacts}
    ''';
  }
}
