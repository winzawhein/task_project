// lib/api_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/appointment.dart';

class ApiHelper {
  static const baseUrl = 
  'http://10.0.2.2:3000/usersss';

  Future<List<Appointment>> fetchAppointments() async {
    final response = await http.get(Uri.parse(baseUrl));
    //  final response1 = await http.get(
    //     Uri.parse(baseUrl),
    //     headers: {
    //       "Content-Type": "application/json",
    //       "user_token": GlobalAccess.accessToken,
    //     },
    //   );
    print("REsponse>>> $response");
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Appointment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  Future<void> addAppointment(Appointment appointment) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add appointment');
    }
  }

  // Similarly, implement methods for updating and deleting appointments
}
