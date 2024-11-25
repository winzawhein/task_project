import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import '../api_service/api_helper.dart';
import '../database_helper/database_helper.dart';
import '../models/appointment.dart';

//  -------------------------------------    My Notifier (Property of Nirvasoft.com)
class GeneralProvider extends ChangeNotifier {
  late Future<List<Appointment>> appointmentsFuture =
      Future.value([]); // Initialize with an empty list

  Future<List<Appointment>> _fetchAppointmentsFromAPI() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString("assets/db.json");

      // Parse the JSON string into a List of dynamic objects (List<Map<String, dynamic>>)
      List<dynamic> data = json.decode(response);
// List<Appointment> appointments= await ApiHelper().fetchAppointments();
      // Convert each item into an Appointment object
      List<Appointment> appointments =
          data.map((item) => Appointment.fromJson(item)).toList();
      print("Appointment>>> $appointments");
      // Optionally, you can store the fetched appointments in the local database for offline use
      for (var appointment in appointments) {
        await DatabaseHelper().insertAppointment(appointment);
      }

      // Return the list of appointments
      return appointments;
    } catch (e) {
      print('Error fetching appointments from JSON file: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<void> fetchAppointments() async {
    // Check internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    print("connectivityResult>>> $connectivityResult");
    for (var element in connectivityResult) {
      if (element == ConnectivityResult.wifi ||
          element == ConnectivityResult.mobile||element==ConnectivityResult.vpn) {
        appointmentsFuture =
            _fetchAppointmentsFromAPI(); // Fetch from API if connected
        notifyListeners();
      } else {
        appointmentsFuture = _fetchAppointmentsFromDatabase();
        notifyListeners();
      }
    }
  }

  // Fetch appointments from the SQLite database
  Future<List<Appointment>> _fetchAppointmentsFromDatabase() async {
    return await DatabaseHelper().fetchAppointments();
  }
}
