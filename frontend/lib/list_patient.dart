import 'package:flutter/material.dart';
import 'patient.dart';
import 'api_service.dart';
import 'add_patient.dart';
import 'view_patient.dart';
import 'edit_patient.dart';

class ListPatientPage extends StatefulWidget {
  @override
  _ListPatientPageState createState() => _ListPatientPageState();
}

class _ListPatientPageState extends State<ListPatientPage> {
  late Future<List<Patient>> _patients;

  @override
  void initState() {
    super.initState();
    _patients = ApiService().getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patients List")),
      body: FutureBuilder<List<Patient>>(
        future: _patients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final patients = snapshot.data!;
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return ListTile(
                title: Text(patient.name),
                subtitle: Text('Age: ${patient.age}, Gender: ${patient.gender}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewPatientPage(patientId: patient.id)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPatientPage(patient: patient)),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPatientPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
