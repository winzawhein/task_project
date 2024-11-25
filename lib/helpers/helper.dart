
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/web.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
//  -------------------------------------    Helpers (Property of Nirvasoft.com)

final logger = Logger();
class MyHelpers{
  static msg(String txt, {int? sec, Color? bcolor}){
    sec ??= 2;
    bcolor ??= Colors.redAccent;
    Fluttertoast.showToast(
      msg: txt,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: sec,  backgroundColor: bcolor, textColor: Colors.white,fontSize: 16.0);
  }
  static showIt(String? value, {String? label}){
  label ??= "Value";
  MyHelpers.msg("$label:  $value",bcolor: Colors.orange);   
  logger.i("$label: $value");
  }
    static Future<String?> getString(BuildContext context,String initvalue,String label) async {
    String? result =  await prompt(
              context,title: Text(label),
              initialValue: initvalue,
              textOK: const Text('OK'), textCancel: const Text('Cancel'),
            );
    return result;
  }
  static Future<int?> getInt(BuildContext context,int initvalue,String label) async {
    int? ret;
    String? result = await getString(context,"$initvalue",label);
      if (result != null) {
        int? parsedResult = int.tryParse(result);
          if (parsedResult != null) { 
            ret = parsedResult;
          }
      }
    return ret;
  }
  static Future<double?> getDouble(BuildContext context,double initvalue,String label) async {
    double? ret;
    String? result = await getString(context,"$initvalue",label);
    if (result != null) {
      double? parsedResult = double.tryParse(result);
      if (parsedResult != null) { 
          ret = parsedResult;
        }
    }
    return ret;
  }


 
  





  static String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    
    String hoursString = hours.toString().padLeft(2, '0');
    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');
    
    return '$hoursString:$minutesString:$secondsString';
  }

  static String formatDouble(double number){
    NumberFormat numberFormat = NumberFormat("#,##0.00");
    String formattedNumber = numberFormat.format(number);
    return formattedNumber;
  }


}