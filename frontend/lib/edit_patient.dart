import 'package:flutter/material.dart';
import 'patient.dart';
import 'api_service.dart';

class EditPatientPage extends StatefulWidget {
  final Patient patient;

  EditPatientPage({required this.patient});

  @override
  _EditPatientPageState createState() => _EditPatientPageState();
}

class _EditPatientPageState extends State<EditPatientPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient.name);
    _ageController = TextEditingController(text: widget.patient.age.toString());
    _genderController = TextEditingController(text: widget.patient.gender);
    _addressController = TextEditingController(text: widget.patient.address);
  }

  void editPatient() {
    final patient = Patient(
      id: widget.patient.id,
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _genderController.text,
      address: _addressController.text,
    );

    ApiService().updatePatient(widget.patient.id, patient).then((_) {
      Navigator.pop(context);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Patient")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _ageController, decoration: InputDecoration(labelText: 'Age')),
            TextField(controller: _genderController, decoration: InputDecoration(labelText: 'Gender')),
            TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address')),
            ElevatedButton(onPressed: editPatient, child: Text('Update Patient')),
          ],
        ),
      ),
    );
  }
}
