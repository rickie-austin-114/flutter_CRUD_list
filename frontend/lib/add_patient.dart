import 'package:flutter/material.dart';
import 'patient.dart';
import 'api_service.dart';

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();

  void addPatient() {
    final patient = Patient(
      id: '',
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _genderController.text,
      address: _addressController.text,
    );

    ApiService().addPatient(patient).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Patient")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _ageController, decoration: InputDecoration(labelText: 'Age')),
            TextField(controller: _genderController, decoration: InputDecoration(labelText: 'Gender')),
            TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address')),
            ElevatedButton(onPressed: addPatient, child: Text('Add Patient')),
          ],
        ),
      ),
    );
  }
}
