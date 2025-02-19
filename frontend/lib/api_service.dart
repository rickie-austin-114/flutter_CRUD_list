import 'dart:convert';
import 'package:http/http.dart' as http;
import 'patient.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5001/api/patients';

  Future<List<Patient>> getPatients() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Patient.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  Future<Patient> getPatient(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load patient');
    }
  }

  Future<void> addPatient(Patient patient) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add patient');
    }
  }

  Future<void> updatePatient(String id, Patient patient) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update patient');
    }
  }

  Future<void> deletePatient(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete patient');
    }
  }
}
