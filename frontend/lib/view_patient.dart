import 'package:flutter/material.dart';
import 'patient.dart';
import 'api_service.dart';

class ViewPatientPage extends StatelessWidget {
  final String patientId;

  ViewPatientPage({required this.patientId});

  Future<Patient> fetchPatient() async {
    return ApiService().getPatient(patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Patient")),
      body: FutureBuilder<Patient>(
        future: fetchPatient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final patient = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${patient.id}'),
                Text('Name: ${patient.name}'),
                Text('Age: ${patient.age}'),
                Text('Gender: ${patient.gender}'),
                Text('Address: ${patient.address}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
