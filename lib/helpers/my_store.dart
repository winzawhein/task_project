import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStore {
  static dynamic prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
  static Future<void> storePolyline(Polyline polyline,String fname) async {
  // Convert Polyline to a JSON string
  final Map<String, dynamic> polylineMap = { 
    'points': polyline.points.map((LatLng point) {
      return {'latitude': point.latitude, 'longitude': point.longitude};
    }).toList(),
    'color': polyline.color.value,
    'width': polyline.width,
  };
  final String polylineJson = jsonEncode(polylineMap);

  // Store JSON string in SharedPreferences
  await MyStore.prefs.setString(fname, polylineJson);
}
// Function to retrieve a Polyline object
static Future<Polyline?> retrievePolyline(String fname) async {  
  final String? polylineJson = MyStore.prefs.getString(fname);
  if (polylineJson == null) {
    return null; // Handle the case where there is no stored polyline
  }
  // Convert JSON string back to Polyline
  final Map<String, dynamic> polylineMap = jsonDecode(polylineJson);

  final List<LatLng> points = (polylineMap['points'] as List).map((point) {
    return LatLng(point['latitude'], point['longitude']);
  }).toList();
  return Polyline( 
    polylineId: const PolylineId(""),
    points: points,
    color: Color(polylineMap['color']),
    width: polylineMap['width'],
  );
  }

  static Future<void> storeDateTimeList(List<DateTime> dateTimeList, String fname) async { 
  // Convert List<DateTime> to List<String>
  final List<String> dateTimeStrings = dateTimeList.map((dateTime) {
    return dateTime.toIso8601String();
  }).toList();

  // Store the list of strings in SharedPreferences
  await prefs.setStringList(fname, dateTimeStrings);
  }

  static Future<List<DateTime>> retrieveDateTimeList(String fname) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve List<String> from SharedPreferences
  final List<String>? dateTimeStrings = prefs.getStringList(fname);
    if (dateTimeStrings == null) {
      return []; // Return an empty list if there is no stored list
    }

    // Convert List<String> back to List<DateTime>
    return dateTimeStrings.map((dateTimeString) {
      return DateTime.parse(dateTimeString);
    }).toList();
  }
}