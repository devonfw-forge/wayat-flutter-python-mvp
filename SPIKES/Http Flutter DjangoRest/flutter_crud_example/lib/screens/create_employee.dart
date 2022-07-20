import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/employee_list.dart';
import '../services/employee_service.dart';
import '../utils/custom_alert_dialog.dart';

class CreateEmployeeForm extends StatefulWidget {
  const CreateEmployeeForm({Key? key}) : super(key: key);

  @override
  CreateEmployeeFormState createState() {
    return CreateEmployeeFormState();
  }
}


class CreateEmployeeFormState extends State<CreateEmployeeForm> {
  // GlobalKey will allow us to validate the form
  final _formKey = GlobalKey<FormState>();
  final EmployeeService _empService = EmployeeService();
  final EmployeeList _employee_list = GetIt.I.get<EmployeeList>();
  String _name = "";
  String _email = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Creation'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Name:"),
            TextFormField( validator: validatorName ),
            const Text("Email:"),
            TextFormField( validator: validatorEmail ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _tryCreateEmployee(context, _name, _email);
                  }
                },
                child: const Text('Submit'),
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

  void _tryCreateEmployee(context, name, email) async {
    if (! await _empService.createEmployee(_name, _email)) {
      showAlertDialog(context, "Error creating employee", "Unable to create employee");
    }
    else {
      _employee_list.updateList();
      Navigator.pop(context);
    }
  }
}