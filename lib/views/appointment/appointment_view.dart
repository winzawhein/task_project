import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_project/views/map/map_screen.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

import '../../api_service/api_helper.dart';
import '../../database_helper/database_helper.dart';
import '../../models/appointment.dart';
import '../../provider/general_provider.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late GeneralProvider provider;
  @override
  void initState() {
    super.initState();
    provider = Provider.of<GeneralProvider>(context, listen: false);

    provider.fetchAppointments();
  }

  // Fetch appointments from the mock API

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        provider.fetchAppointments();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        body: FutureBuilder<List<Appointment>>(
          future:provider. appointmentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
      
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading appointments'));
            }
      
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No appointments available.'));
            }
      
            final appointments = snapshot.data!;
      
            return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
      final appointment = appointments[index];
      return Card(  // Wrapping with a Card for better styling (optional)
      color: Colors.grey.shade700,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          title: Text(appointment.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Customer: ${appointment.customerName}", style: const TextStyle(fontSize: 14)),
              Text("Company: ${appointment.company}", style: const TextStyle(fontSize: 14)),
              Text("Description: ${appointment.description}", style: const TextStyle(fontSize: 14)),
              Text("Date & Time: ${appointment.appointmentDate.toLocal().toString()}", style: const TextStyle(fontSize: 14)),
              Row(children: [
                Text("Location: ${appointment.location}", style: const TextStyle(fontSize: 14)),
                IconButton(onPressed: (){
  Navigator.pushReplacementNamed(
            context,
            MapScreen.routeName,
          );
                }, icon: const Icon(Icons.map_rounded,color: Colors.redAccent,))
              ],)
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: () async {
              await DatabaseHelper().deleteAppointment(appointment.id!);
              provider.fetchAppointments(); // Refresh the list after deletion
            },
          ),
          onTap: () {
            // Navigate to a detail/edit screen if needed
          },
        ),
      );
        },
      )
      ;
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to Appointment creation screen
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
