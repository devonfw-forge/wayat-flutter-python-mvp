import 'package:flutter/material.dart';
import 'package:flutter_crud_example/models/employee.dart';
import 'package:flutter_crud_example/models/employee_list.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../services/employee_service.dart';
import '../utils/custom_alert_dialog.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final EmployeeList _employee_list = GetIt.I.get<EmployeeList>();
  final EmployeeService _empService = EmployeeService();
  final employeeListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _employee_list.updateList();
    return Scaffold(
      key: employeeListKey,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: Center(
        child: Observer(
          builder:  (_) => ListView.builder(
              itemCount: _employee_list.value.length,
              itemBuilder: (BuildContext context, int index) {
                var data = _employee_list.value[index];
                return Card(
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {
                      setState(() {});
                    },
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        data.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(
                        child: TextButton(
                          child: const Text('Edit'),
                          onPressed: () {
                              Navigator.pushNamed(context, '/update', 
                                arguments: <String, Employee> { 'employee': data });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            _tryDeleteEmployee(context, data.id);
                          },
                        ),
                      ),

                    ],
                  ),
                );
              },
            )
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.plus_one),
      )
    );
  }

  void _tryDeleteEmployee(context, id) async {
    if (! await _empService.removeEmployee(id)) {
      showAlertDialog(context, "Error deleting employee", "Unable to delete employee");
    }
    else {
      _employee_list.updateList();
      Navigator.pop(context);
    }
  }
}