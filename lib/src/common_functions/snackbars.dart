import 'package:dealsify_production/src/common_functions/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/colors_and_icons/images.dart';

class Open {

  static successSnackBar(msg,{withoutIcon}){
    return Get.snackbar(
      '',
      msg?.toString() ?? '',
      icon: withoutIcon == true ? null :const Icon(Icons.check_circle, color: Colors.white,size: 15),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      padding: symmetric(h: 5, v: 0),
      margin: all(10),
      maxWidth: double.infinity,
      borderRadius: 8,
      isDismissible: true,
      titleText: const Stack(),
      // messageText: Padding(
      //   padding: only(b: 5),
      //   child: txt.custom_(msg: withoutIcon == true ? "   $msg": msg?.toString() ?? '',color: white,fontSize: 13),
      // ),
      duration: const Duration(seconds: 3),
    );
  }

  static warningSnackBar(msg){
    return Get.snackbar(
      '',
      msg.toString(),
      icon: const Icon(Icons.warning, color: Colors.yellow,size: 15),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      padding: symmetric(h: 5, v: 0),
      margin: all(10),
      maxWidth: double.infinity,
      borderRadius: 8,
      isDismissible: true,
      titleText: const Stack(),
      // messageText: Padding(
      //   padding: only(b: 5),
      //   child: txt.custom_(msg: msg?.toString() ?? '' ,color: white,fontSize: 13),
      // ),
      duration: const Duration(seconds: 3),
    );
  }

  static snackBarComingSon(){
    return Get.rawSnackbar(
      message: "Coming soon!",
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      borderRadius: 3,
      backgroundColor: Colors.yellow,
    );
  }

  // static dynamic internet_check_snackBar(){
  //   if (Services.internet.connection.value.isFalse){
  //     Get.snackbar(
  //       '',
  //       "",
  //       icon: const Icon(Icons.network_check, color: Colors.white,size: 17),
  //       backgroundColor: red,
  //       snackPosition: SnackPosition.TOP,
  //       colorText: Colors.white,
  //       padding: symmetric(h: 5, v: 0),
  //       margin: all(10),
  //       maxWidth: double.infinity,
  //       borderRadius: 5,
  //       isDismissible: true,
  //       titleText: const Stack(),
  //       messageText: Padding(
  //         padding: only(b: 5),
  //         child: const Text("Check your internet connection!",style: TextStyle(color: white,fontSize: 13),),
  //       ),
  //       duration: const Duration(seconds: 3),
  //     );
  //   }
  // }

  static stageUpdated({msg}) {
      return Get.snackbar(
        '',
        "Stage Updated successfully.",
        icon: const Icon(Icons.check, color: Colors.white,size: 18),
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        padding: symmetric(h: 5, v: 0),
        margin: all(10),
        maxWidth: double.infinity,
        borderRadius: 5,
        isDismissible: true,
        titleText: const Stack(),
        messageText: Padding(
          padding: only(b: 5),
          child: Text( msg ?? "Stage Updated successfully." ,style: TextStyle(color: Colors.white,fontSize: 13),),
        ),
        duration: const Duration(seconds: 3),
      );
  }

  static openDateErrorSnackbar(msg) {
    return Get.snackbar(
      '',
      msg.toString(),
      icon: const Icon(Icons.warning, color: Colors.yellow,size: 15),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      padding: symmetric(h: 5, v: 0),
      margin: all(10),
      maxWidth: double.infinity,
      borderRadius: 8,
      isDismissible: true,
      titleText: const Stack(),
      messageText: Padding(
        padding: only(b: 5),
        child: Text(
          msg ?? "" ,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: FontFamily.regularMulish,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  static credential_true_snackBar(context) {
    final snackBar = SnackBar(
      content: const Text(
        "Welcome! You've logged in successfully.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: FontFamily.regularMulish,
        ),
      ),
      backgroundColor: Colors.teal,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  static credential_fail_snackBar(context) {
    final errorSnackBar = SnackBar(
      content: const Text(
        "Wrong username and password",
        style: TextStyle(
          color: Colors.white,
          fontFamily: FontFamily.regularMulish,
          fontSize: 16,
        ),
      ),
      backgroundColor: Colors.red, // Error background color
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
  }


  // static credential_true_snackBar(context){
  //   return Get.snackbar(
  //     '',
  //     "Welcome! You've logged in successfully.",
  //     icon: const Icon(Icons.check, color: Colors.white,size: 18),
  //     backgroundColor: Colors.green,
  //     snackPosition: SnackPosition.TOP,
  //     colorText: Colors.white,
  //     padding: symmetric(h: 5, v: 0),
  //     margin: all(10),
  //     maxWidth: double.infinity,
  //     borderRadius: 5,
  //     isDismissible: true,
  //     titleText: const Stack(),
  //     messageText: Padding(
  //       padding: only(b: 5),
  //       child: const Text("Welcome! You've logged in successfully." ,style: TextStyle(color: Colors.white,fontSize: 13),),
  //     ),
  //     duration: const Duration(seconds: 3),
  //   );
  // }

  // static credential_fail_snackBar(){
  //   return Get.snackbar(
  //     '',
  //     "Wrong username and password",
  //     icon: const Icon(Icons.close, color: Colors.white,size: 18),
  //     backgroundColor: Colors.red,
  //     snackPosition: SnackPosition.TOP,
  //     colorText: Colors.white,
  //     padding: symmetric(h: 5, v: 0),
  //     margin: all(10),
  //     maxWidth: double.infinity,
  //     borderRadius: 5,
  //     isDismissible: true,
  //     titleText: const Stack(),
  //     messageText: Padding(
  //       padding: only(b: 5),
  //       child: const Text("Wrong username and password" ,style: TextStyle(color: Colors.white,fontSize: 13),),
  //     ),
  //     duration: const Duration(seconds: 3),
  //   );
  // }

}
