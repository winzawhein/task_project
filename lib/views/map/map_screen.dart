import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const routeName = '/map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;

  // To keep track of the camera position and selected location
  final Set<Marker> _markers = {};
  
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get current location of the user
  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      _mapController?.moveCamera(CameraUpdate.newLatLng(_selectedLocation!));
    });
  }

  // Called when user selects a location on the map
  void _onMapTapped(LatLng latLng) {
    setState(() {
      _selectedLocation = latLng;
      _markers.clear();  // Remove existing markers
      _markers.add(Marker(
        markerId: const MarkerId("selected-location"),
        position: latLng,
        infoWindow: const InfoWindow(title: 'Selected Location'),
      ));
    });
  }

  // Save the selected location (you can replace it with actual saving logic)
  void _saveLocation() {
    if (_selectedLocation != null) {
      print('Saved Location: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location saved!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No location selected!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select and Save Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveLocation,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _selectedLocation ?? const LatLng(0, 0),
          zoom: 10.0,
        ),
        onTap: _onMapTapped,  // Callback when user taps the map
        markers: _markers,  // Show the marker for the selected location
      ),
    );
  }
}
