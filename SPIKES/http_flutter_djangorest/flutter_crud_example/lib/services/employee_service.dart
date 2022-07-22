import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../env.sample.dart';
import '../models/employee.dart';

class EmployeeService {
  late String _baseUrl;

  EmployeeService() {
    if (Platform.isAndroid) {
      _baseUrl = Env.androidUrlPrefix;
    } else {
      _baseUrl = Env.urlPrefix;
    }
  }

  /// Return a list of all the employees stored in the backend. 
  /// It uses BASE_URL+/employee as url and GET method.
  Future<List<Employee>> listEmployees() async {
    http.Response response = await http.get(
      Uri.parse("$_baseUrl/employee"),
      headers: { "Accept" : "application/json" });
    
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Employee> employees = items.map<Employee>((json) {
      return Employee.fromJson(json);
    }).toList();

    return employees;
  }

  /// Create an employee with a name and email (no validation for the moment).
  /// Returns false in case of error, otherwise true.
  /// It uses BASE_URL+/employee as url and POST method.
  Future<bool> createEmployee(String name, String email) async {
    var res = await http.post(
      Uri.parse("$_baseUrl/employee"),
      headers: { "Accept" : "application/json" },
      body: { "name" : name, "email" : email });
    if (res.statusCode == 400) return false;
    return true;
  }

  /// Update name and email of an employee with his/her id (no validation for the moment).
  /// Returns false in case of error, otherwise true.
  /// It uses BASE_URL+/employee/$id as url and PUT method.
  Future<bool> updateEmployee(int id, String name, String email) async {
    var res = await http.put(
      Uri.parse("$_baseUrl/employee/$id"),
      headers: { "Accept" : "application/json" },
      body: { "name" : name, "email" : email });
    if (res.statusCode == 405) return false;
    return true;
  }

  /// Remove an employee with his/her id (no validation for the moment).
  /// Returns false in case of error, otherwise true.
  /// It uses BASE_URL+/employee/$id as url and DELETE method.
  Future<bool> removeEmployee(int id) async {
    var res = await http.delete(Uri.parse("$_baseUrl/employee/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    });
    if (res.statusCode == 404) return false;
    return true;
  }
}