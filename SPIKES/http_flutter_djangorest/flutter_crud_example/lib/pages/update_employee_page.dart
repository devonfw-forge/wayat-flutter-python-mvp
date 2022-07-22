import 'package:flutter/material.dart';
import 'package:flutter_crud_example/models/employee.dart';
import 'package:get_it/get_it.dart';

import '../models/employee_list.dart';
import '../services/employee_service.dart';
import '../utils/custom_alert_dialog.dart';

class UpdateEmployeeForm extends StatefulWidget {
  const UpdateEmployeeForm({Key? key}) : super(key: key);

  @override
  UpdateEmployeeFormState createState() {
    return UpdateEmployeeFormState();
  }
}


class UpdateEmployeeFormState extends State<UpdateEmployeeForm> {
  // GlobalKey will allow us to validate the form
  final _formKey = GlobalKey<FormState>();
  final EmployeeService _empService = EmployeeService();
  final EmployeeList _employee_list = GetIt.I.get<EmployeeList>();
  int _id = -1;
  String _name = "";
  String _email = "";
  
  @override
  Widget build(BuildContext context) {

    Map<String, Employee>? args = ModalRoute.of(context)!.settings.arguments as Map<String, Employee>?;
    _id = args!['employee']!.id;
    _name = args['employee']!.name;
    _email = args['employee']!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Update'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Name:"),
            TextFormField( validator: validatorName, initialValue: _name ),
            const Text("Email:"),
            TextFormField( validator: validatorEmail, initialValue: _email ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _tryUpdateEmployee(context);
                  }
                },
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      )
    );
  }

  String? validatorName(value) {
    value = value ?? "";
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    _name = value;
    return null;
  }
  
  String? validatorEmail(value) {
    value = value ?? "";
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    _email = value;
    return null;
  }

  void _tryUpdateEmployee(context) async {
    if (! await _empService.updateEmployee(_id, _name, _email)) {
      showAlertDialog(context, "Error updating employee", "Unable to update employee");
    }
    else {
      _employee_list.updateList();
      Navigator.pop(context);
    }
  }
}