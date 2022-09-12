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
  List<Group> get groups {
    _$groupsAtom.reportRead();
    return super.groups;
  }

  @override
  set groups(List<Group> value) {
    _$groupsAtom.reportWrite(value, super.groups, () {
      super.groups = value;
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
  String toString() {
    return '''
groups: ${groups}
    ''';
  }
}
