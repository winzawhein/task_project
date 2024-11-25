

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_math/flutter_geo_math.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';

// import '../helpers/helper.dart';
// import '../helpers/my_store.dart';
// import '../provider/location_notifier.dart';

// //  -------------------------------------    GeoData (Property of Nirvasoft.com)
// class GeoData{
//   // GPS Data
//   static int counter=0;
//   static double currentLat=0;
//   static double currentLng=0; 
//   static DateTime currentDtime= DateTime.now();
//   static bool tripStarted=false;
//   static Polyline polyline01 = Polyline(points: [], color: Colors.red,strokeWidth: origThickenss,);
//   static List<DateTime> dtimeList01=[];
//   static Polyline polyline01Fixed = Polyline(points: [], color: Colors.blue,strokeWidth: optiThickenss,);
//   static List<DateTime> dtimeList01Fixed=[];
//   static bool mapready=false;
//   static Location location =Location();

//   // App Parameters 
//   static bool showLatLng=false;
//   static bool centerMap=true;
//   static bool listenChanges=true;
//   static double zoom=16;
//   static int interval=1000;
//   static double distance=0;
//   static double minDistance=10;
//   static double maxDistance=30;
//   static double origThickenss=3;
//   static double optiThickenss=6;
//   static const double defaultLat=1.2926;
//   static const double defaultLng=103.8448;

//   static void resetData(){
//     counter=0;
//     currentLat=0;
//     currentLng=0;
//     currentDtime= DateTime.now();
//     tripStarted=false;
//     polyline01.points.clear();
//     dtimeList01.clear();
//     polyline01Fixed.points.clear();
//     dtimeList01Fixed.clear(); 
//   }
//   static double currentSpeed(Polyline polyline, List<DateTime> dt, int range){
//     double speed=0;
//     int range =10;
//     double dist=0;
//     int time= 0;
//     FlutterMapMath fmm = FlutterMapMath();
//     if (polyline.points.length>range && dt.length>range){
//       time= dt[dt.length-1].difference(dt[dt.length-range]).inSeconds;
//       for (int i=polyline.points.length-range; i<polyline.points.length-1; i++){
//         dist+=fmm.distanceBetween(
//               polyline.points[i].latitude,            //latest points
//               polyline.points[i].longitude,
//               polyline.points[i-1].latitude, 
//               polyline.points[i-1].longitude,"meters").round();
//       }
//       speed=dist/time*60*60/1000;
//     }
//     return speed;
//   }
//   static int totalTime(List<DateTime> dt){
//     if (dt.isEmpty) return 0;
//     Duration difference = dt[dt.length-1].difference(dt[0]);
//     return (difference.inSeconds).round();
//   } 
 
  
//   static double totalDistance(Polyline polyline){
//     double dist=0;
//     FlutterMapMath fmm = FlutterMapMath();
//     for (int i=1; i<polyline.points.length-1; i++){
//       dist+=fmm.distanceBetween(
//             polyline.points[i].latitude,            //latest points
//             polyline.points[i].longitude,
//             polyline.points[i-1].latitude, 
//             polyline.points[i-1].longitude,"meters").round();
//     }
//     return (dist/1000);
//   }

//   static void updateLocation(double lat, double lng, DateTime dt,{LocationNotifier? locProvider}){
//     if (lat!=0 && lng!=0){
//         GeoData.counter++;
//         GeoData.currentLat=lat;
//         GeoData.currentLng=lng;
//         GeoData.currentDtime=dt;
//         if (tripStarted){
//           polyline01.points.add(LatLng(lat, lng));
//           dtimeList01.add(dt);
//           // Geo Data Optimization
//           FlutterMapMath fmm = FlutterMapMath();
//           double dist=fmm.distanceBetween(
//                 polyline01.points[polyline01.points.length-1].latitude,            //latest points
//                 polyline01.points[polyline01.points.length-1].longitude,
//                 polyline01.points[polyline01.points.length-2].latitude, 
//                 polyline01.points[polyline01.points.length-2].longitude,"meters");
//           int time= dtimeList01[dtimeList01.length-1].difference(dtimeList01[dtimeList01.length-2]).inSeconds;
//           double speed=dist/time;
//           //if (AppConfig.shared.log>=3) 
//           logger.i("Speed: $speed  ($dist / $time)");

//           polyline01Fixed.points.add(LatLng(lat, lng - 0.000003));
//           dtimeList01Fixed.add(dt);
//           // ---------(C or -3)-------(B or -2)--------(A or -1 of original or last point)
//           if (polyline01Fixed.points.length>=3){  
//             double dist2=fmm.distanceBetween(
//                 polyline01Fixed.points[polyline01Fixed.points.length-1].latitude,            //latest points
//                 polyline01Fixed.points[polyline01Fixed.points.length-1].longitude,
//                 polyline01Fixed.points[polyline01Fixed.points.length-2].latitude, 
//                 polyline01Fixed.points[polyline01Fixed.points.length-2].longitude,"meters");
//             double dist1=fmm.distanceBetween(
//                 polyline01Fixed.points[polyline01Fixed.points.length-2].latitude, 
//                 polyline01Fixed.points[polyline01Fixed.points.length-2].longitude,
//                 polyline01Fixed.points[polyline01Fixed.points.length-3].latitude,
//                 polyline01Fixed.points[polyline01Fixed.points.length-3].longitude,"meters");
                
//             if ((dist1>minDistance && dist1<maxDistance) || (dist2>minDistance && dist2<maxDistance)){
//               //if (AppConfig.shared.log>=3) 
//               logger.i("Keep: $dist1 $dist2 ");                                 // Keep point B
//             } else {
//               polyline01Fixed.points.removeAt(polyline01Fixed.points.length-2); // Remove point B
//               dtimeList01Fixed.removeAt(dtimeList01Fixed.length-2);
//               //if (AppConfig.shared.log>=3) 
//               logger.i("Remove: $dist1 $dist2 ");
//             }
//           }
          
//         }
//           MyStore.storePolyline(polyline01,"polyline01");
//           MyStore.storeDateTimeList(dtimeList01, "dtimeList01");
//           MyStore.storePolyline(polyline01Fixed,"polyline01Fixed");
//           MyStore.storeDateTimeList(dtimeList01Fixed, "dtimeList01Fixed");

//           double tDist=totalDistance(polyline01Fixed);
//           int tTime=totalTime(dtimeList01Fixed);
//           double tSpeed = currentSpeed(polyline01Fixed, dtimeList01Fixed, 5);
//           double tAmount = calculateAmount(tDist, tTime);
//           locProvider?.updateTripData(GeoData.tripStarted, tDist, tTime,  tSpeed,tAmount);
//     }
//   }

//   static double calculateAmount(double distance, int time){  // replace it with real calculation
//     double ret=0;
//     if (distance>0){ ret = 2500+(distance * 2500);
//     } else { ret = 0; }
//     return ret;  
//   }

//   static void startTrip(){
//     polyline01.points.clear();
//     tripStarted=true;
//   }
//   static void endTrip(){
//     tripStarted=false;
//   }
//   static Future<bool> chkPermissions(Location location) async{
//     bool serviceEnabled;
//     PermissionStatus permissionGranted; 
//     try { 
//         serviceEnabled = await location.serviceEnabled();
//         if (!serviceEnabled) {
//           serviceEnabled = await location.requestService();
//           if (serviceEnabled) {
//             logger.i("Service Enabled");
//           } else {
//             logger.i("Service Disabled");
//             return false;
//           }
//         }
//         permissionGranted = await location.hasPermission();
//         if (permissionGranted == PermissionStatus.denied) {
//           permissionGranted = await location.requestPermission();
//           if (permissionGranted == PermissionStatus.granted) {
//             logger.i("Permission Granted");
//           } else {
//             logger.i("Permission Denined");
//             return false;
//           }
          
//         }
//     } catch (e) {
//       logger.e("Permission Exception (getCurrentLocation)");
//     return false;
//     }
//     return true;
//   } 
//   static Future<LocationData?> getCurrentLocation(Location location, {LocationNotifier? locProvider}) async { 
//       LocationData locationData;
//       bool serviceEnabled=await chkPermissions(location);
//       if (serviceEnabled) {
//         locationData = await location.getLocation();
//         if (locProvider==null){
//         GeoData.updateLocation(locationData.latitude!, locationData.longitude!, DateTime.now());
//          } else {
//         GeoData.updateLocation(locationData.latitude!, locationData.longitude!, DateTime.now(),locProvider: locProvider);
//       }
//         return locationData;
//       } else {
//         return null;
//       } 
//   }
// }

