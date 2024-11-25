
import 'package:flutter/material.dart';
import 'package:test_project/setting_controller.dart';
import 'package:test_project/utils/util.dart';

import 'views/loadingpage.dart';
import 'views/map/map_screen.dart';
import 'views/root_page.dart';

//  -------------------------------------    My App (Property of Nirvasoft.com)
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            //  AppLocalizations.delegate,
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
          ],
          // supportedLocales: L10n.all,
          locale:settingsController.locale, 
          // onGenerateTitle: (BuildContext context) =>
          //     AppLocalizations.of(context)!.hello,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Util().primaryColor,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Util().primaryColor),
            tabBarTheme: TabBarTheme(
              labelColor: Util().primaryColor,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Util().primaryColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings, // Route Settings
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case RootPage.routeName:
                    return const RootPage();
                    case MapScreen.routeName:
                    return const MapScreen();
                  default:
                    return const LoadingPage();
                }
              },
            );
          },
        );
      },
    );
  }
}
