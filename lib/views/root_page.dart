
import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';
import 'package:test_project/utils/util.dart';
import 'package:test_project/views/appointment/appointment_view.dart';

import '../provider/general_provider.dart';
import 'settings/setting_view.dart';  
//  -------------------------------------    Root Page (Property of Nirvasoft.com)
class RootPage extends StatefulWidget {
  static const routeName = '/root';
  const RootPage({super.key});
  @override
  State<RootPage> createState() => _RootPageState();
}
class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  late GeneralProvider provider ;  // Provider Declaration and init
  @override
  void initState() {          // Init
    super.initState(); 
    provider = Provider.of<GeneralProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {  // Widget
    return  Consumer<GeneralProvider>(
      builder: (BuildContext context, GeneralProvider value, Widget? child) {
      return 
        Scaffold(
          appBar: AppBar(
            backgroundColor: Util.appBarColor,
            title: const Text("Appointment"), 
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(decoration: BoxDecoration(color: Util().primaryColor),child: const Text('Menu', style: TextStyle(color: Colors.white,fontSize: 24,),),),
              
              ],
            ),
          ),
          body:  DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                 AppointmentScreen(),
                 const Center(child: Text("setting"),)
                    ],
                  ),
                ),
                Container(
                  color: Util.appBarColor,
                  child: const TabBar(
                    
                    tabs: [
                      Tab( text: "Home", icon:Icon(Icons.home), ),
                      // Tab( text: AppLocalizations.of(context)!.map, icon:const Icon(Icons.map), ),
                      // Tab( text: AppLocalizations.of(context)!.trip, icon:const Icon(Icons.add_location_alt_outlined),  ),
                      Tab( text: "Setting", icon:Icon(Icons.settings), ),
                    ],
                  ),
                ), 
              ],
            ),
          ),
        );
      }
    ); 
  }
} 