import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';
import 'provider/general_provider.dart';
import 'provider/location_notifier.dart';
import 'setting_controller.dart';
import 'views/settings/setting_service.dart';

void main() async{
   WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
   final settingsController = SettingsController(SettingsService()); 
  await settingsController.loadSettings(); 
  runApp(
      MultiProvider(
      providers: [   
        ChangeNotifierProvider(create: (context) => GeneralProvider()), // Provider
        ChangeNotifierProvider(create: (context) => LocationNotifier()), 
      ],
      child:  MyApp(settingsController: settingsController,))
  );
  // FlutterNativeSplash.remove();

}
