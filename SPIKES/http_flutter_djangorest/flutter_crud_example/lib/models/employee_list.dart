import 'package:mobx/mobx.dart';

import '../services/employee_service.dart';
import 'employee.dart';

part 'employee_list.g.dart';

class EmployeeList = _EmployeeList with _$EmployeeList;

abstract class _EmployeeList with Store {
  final EmployeeService _empService = EmployeeService();
  
  @observable
  List<Employee> value = [];

  @action
  Future<List<Employee>> updateList() async {
    Future<List<Employee>> aux = _empService.listEmployees();
    value = await aux;
    return aux;
  }
}