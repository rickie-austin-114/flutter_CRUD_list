import 'package:flutter/material.dart';
import 'package:frontend/patient.dart';
import 'list_patient.dart';  // Import the ListPatientPage
import 'add_patient.dart';   // Import the AddPatientPage
import 'view_patient.dart';  // Import the ViewPatientPage
import 'edit_patient.dart';  // Import the EditPatientPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route to ListPatientPage
      initialRoute: '/',
      routes: {
        '/': (context) => ListPatientPage(),
        '/add': (context) => AddPatientPage(),
        '/view': (context) => ViewPatientPage(patientId: '0'),  // Set a default patientId here for now
        '/edit': (context) => EditPatientPage(patient: Patient(id: "1", address: "df", name: "fds", age: 32, gender: "m")),  // Set a default null for now
      },
    );
  }
}
