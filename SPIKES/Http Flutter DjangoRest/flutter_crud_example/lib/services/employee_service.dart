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

  /// Return a list of all the employees stored in the backend
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

  Future<bool> createEmployee(String name, String email) async {
    var res = await http.post(
      Uri.parse("$_baseUrl/employee"),
      headers: { "Accept" : "application/json" },
      body: { "name" : name, "email" : email });
    if (res.statusCode == 400) return false;
    return true;
  }

  Future<bool> updateEmployee(int id, String name, String email) async {
    var res = await http.put(
      Uri.parse("$_baseUrl/employee/$id"),
      headers: { "Accept" : "application/json" },
      body: { "name" : name, "email" : email });
    if (res.statusCode == 405) return false;
    return true;
  }

  Future<bool> removeEmployee(int id) async {
    var res = await http.delete(Uri.parse("$_baseUrl/employee/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    });
    if (res.statusCode == 404) return false;
    return true;
  }
}