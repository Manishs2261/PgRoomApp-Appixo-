import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';


class AppHelperFunction {
  static Color? getColor(String value) {
    // Define your product specific colors here and it will match the
    // attribute colors

    if (value == 'green') {
      return Colors.green;
    } else if (value == 'greenAccent') {
      return Colors.greenAccent;
    } else if (value == 'red') {
      return Colors.red;
    } else if (value == 'blue') {
      return Colors.blue;
    } else if (value == 'pink') {
      return Colors.pink;
    } else if (value == 'grey') {
      return Colors.grey;
    } else if (value == 'purple') {
      return Colors.purple;
    } else if (value == 'black') {
      return Colors.black;
    } else if (value == 'white') {
      return Colors.white;
    } else if (value == 'brown') {
      return Colors.brown;
    } else if (value == 'teal') {
      return Colors.teal;
    } else if (value == 'indigo') {
      return Colors.indigo;
    }
    return null;
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),


      ),
    );
  }

  static void showFlashbar(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(Get.context!);
  }

  static void showAlert(String title, String message,onPressedYes) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No',style: TextStyle(fontSize: 18),),
              ),
              TextButton(
                onPressed: onPressedYes,
                child: const Text('Yes',style: TextStyle(fontSize: 18),),
              ),
            ],
          );
        });
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme
        .of(context)
        .brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery
        .of(Get.context!)
        .size;
  }

  static double screenHeight() {
    return MediaQuery
        .of(Get.context!)
        .size
        .height;
  }

  static double screenWidth() {
    return MediaQuery
        .of(Get.context!)
        .size
        .width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }


  static void fieldFocusChange(BuildContext context,FocusNode current,FocusNode nextFocus){

    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static void showDialogCenter(bool barrier){
    showDialog(
      barrierDismissible: barrier,
        context: Get.context!,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(color: Colors.white,),
          );
        });
  }


  static Future<bool> checkInternetAvailability() async {
    Connectivity connectivity = Connectivity();
    //check a internet connection
    bool isValue = false ;
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
        isValue = false ;
      }else if (value == ConnectivityResult.mobile){
        isValue = true;
      } else if (value == ConnectivityResult.wifi){
        isValue = true;
      }else if (value == ConnectivityResult.vpn){
        isValue = true;
      }else if (value == ConnectivityResult.bluetooth){
        isValue = true;
      }
    });

    return isValue;

  }
}
