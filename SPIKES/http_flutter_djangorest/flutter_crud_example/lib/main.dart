import 'package:flutter/material.dart';
import 'package:flutter_crud_example/models/employee_list.dart';
import 'package:flutter_crud_example/pages/create_employee_page.dart';
import 'package:flutter_crud_example/pages/home_page.dart';
import 'package:flutter_crud_example/pages/update_employee_page.dart';
import 'package:get_it/get_it.dart';

void main() {
  registerStores();
  runApp(const App());
}

void registerStores() {
  GetIt.I.registerLazySingleton<EmployeeList>(
    () => EmployeeList());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter & Django',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/create': (context) => const CreateEmployeeForm(),
        '/update': (context) => const UpdateEmployeeForm(),
      },
    );
  }
}