// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GroupsController on _GroupsController, Store {
  late final _$groupsAtom =
      Atom(name: '_GroupsController.groups', context: context);

  @override
  ObservableList<Group> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(ObservableList<Group> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
    });
  }

  late final _$selectedGroupAtom =
      Atom(name: '_GroupsController.selectedGroup', context: context);

  @override
  Group? get selectedGroup {
    _$selectedGroupAtom.reportRead();
    return super.selectedGroup;
  }

  @override
  set selectedGroup(Group? value) {
    _$selectedGroupAtom.reportWrite(value, super.selectedGroup, () {
      super.selectedGroup = value;
    });
  }

  late final _$editGroupAtom =
      Atom(name: '_GroupsController.editGroup', context: context);

  @override
  bool get editGroup {
    _$editGroupAtom.reportRead();
    return super.editGroup;
  }

  @override
  set editGroup(bool value) {
    _$editGroupAtom.reportWrite(value, super.editGroup, () {
      super.editGroup = value;
    });
  }

  late final _$updatingGroupAtom =
      Atom(name: '_GroupsController.updatingGroup', context: context);

  @override
  bool get updatingGroup {
    _$updatingGroupAtom.reportRead();
    return super.updatingGroup;
  }

  @override
  set updatingGroup(bool value) {
    _$updatingGroupAtom.reportWrite(value, super.updatingGroup, () {
      super.updatingGroup = value;
    });
  }

  late final _$_GroupsControllerActionController =
      ActionController(name: '_GroupsController', context: context);

  @override
  void setGroups(List<Group> groups) {
    final _$actionInfo = _$_GroupsControllerActionController.startAction(
        name: '_GroupsController.setGroups');
    try {
      return super.setGroups(groups);
    } finally {
      _$_GroupsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditGroup(bool editValue) {
    final _$actionInfo = _$_GroupsControllerActionController.startAction(
        name: '_GroupsController.setEditGroup');
    try {
      return super.setEditGroup(editValue);
    } finally {
      _$_GroupsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdatingGroup(bool updatingGroup) {
    final _$actionInfo = _$_GroupsControllerActionController.startAction(
        name: '_GroupsController.setUpdatingGroup');
    try {
      return super.setUpdatingGroup(updatingGroup);
    } finally {
      _$_GroupsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groups: ${groups},
selectedGroup: ${selectedGroup},
editGroup: ${editGroup},
updatingGroup: ${updatingGroup}
    ''';
  }
}
