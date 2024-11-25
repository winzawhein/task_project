//  -------------------------------------    Loading
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'root_page.dart';

//  -------------------------------------    Loading (Property of Nirvasoft.com)
class LoadingPage extends StatefulWidget {
  static const routeName = '/loading';
  const LoadingPage({super.key});
  @override
  State<LoadingPage> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    loading(context);
  }

  Future loading(BuildContext context) async {
    // Decide where to go based on Global Data read from secure storage.
    Timer(const Duration(seconds: 2), () {
      setState(() {
        if (1==1) {
          Navigator.pushReplacementNamed(
            context,
            RootPage.routeName,
          );
        } 
        // else if (GlobalAccess.userID.isNotEmpty ||
        //     GlobalAccess.accessToken.isNotEmpty) {
        //   Navigator.pushReplacementNamed(
        //     context,
        //     RootPage.routeName,
        //   );
        // }
         else {
          // Navigator.pushReplacementNamed(
          //   context,
          //   SigninPage.routeName,
          // );
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: const Image(
            image: AssetImage("assets/images/flutter_logo.png"),
            width: 130,
            height: 130,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Welcome ',
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: SizedBox(
            height: 30,
            child: SpinKitWave(
              color: Colors.grey[400],
              type: SpinKitWaveType.start,
              size: 40.0,
              itemCount: 5,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        const Text(
          'Version ',
        ),
      ]),
    );
  }
}
