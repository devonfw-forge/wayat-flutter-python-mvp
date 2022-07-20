// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeList on _EmployeeList, Store {
  late final _$valueAtom = Atom(name: '_EmployeeList.value', context: context);

  @override
  List<Employee> get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(List<Employee> value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$updateListAsyncAction =
      AsyncAction('_EmployeeList.updateList', context: context);

  @override
  Future<List<Employee>> updateList() {
    return _$updateListAsyncAction.run(() => super.updateList());
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
