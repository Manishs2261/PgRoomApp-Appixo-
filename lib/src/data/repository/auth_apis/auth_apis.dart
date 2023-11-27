import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/splash/controller/splash_controller.dart';
import '../apis/apis.dart';


class AuthApisClass {
  static EmailOTP emailOtp = EmailOTP();
  static Connectivity connectivity = Connectivity();
  static bool otpSend = false;

  // =======google sing =============
  static handleGoogleButtonClick(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar('Please Check Your Internet Connection');
      } else {
        signInWithGoogle().then((value) async {
          // sharedPreferences code
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //upload user uid data in SharedPreferences
          preferences.setString('userUid', value.user!.uid);
          // initialize variable
          finalUserUidGlobal = preferences.getString('userUid');
          log('\nUser :${value.user}');
          Get.offAllNamed(RoutesName.homeScreen);
        });
      }
    });
  }

  //check for user login or not
  static Future<void>checkUserLogin(routesName)async{
    (ApisClass.auth.currentUser?.uid == finalUserUidGlobal)
        ? Get.toNamed(routesName)
        : Get.defaultDialog(
        title: "Login please",
        middleText: "Without login your are not post home",
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.offAllNamed(RoutesName.loginScreen);
              },
              child: const Text("Login"))
        ]);
  }




  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //====sing with email and password==========

  static Future<bool> singEmailIdAndPassword(String email, String pass) async {
    try {
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Weak Password",
            "This password is weak use Number,"
                "Character");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email-already-in-use", "This email id is already exist");
        return false;
      }
    } catch (e) {
      Get.snackbar(" InValid", "Sign");
      AppLoggerHelper.info("$e");
    }

    return true;
  }

// ======login with email id and password====

  static Future<bool> loginEmailAndPassword(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      AppLoggerHelper.info("${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("NO User found", "User are not registered.");

        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "InValid", "password");

        return false;
      } else {
        Get.snackbar("Invalid", "Email id and password");
        AppLoggerHelper.info(e.code);
        return false;
      }
    }

    return true;
  }

  //===========send opt email verification ===============
  static Future<bool> sendEmailOtpVerification(String email) async {
    //====send otp code ==========
    emailOtp.setConfig(
      appEmail: "sahusanju138@gmail.com",
      appName: "~ By Pg Room App",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );
    if (await emailOtp.sendOTP() == true) {
      otpSend = true;
      return true;
    } else {
      otpSend = false;
      return false;
    }
  }

  //=========== otp verification code=============

  static Future<bool> otpSubmitVerification(String otp) async {
    if (await emailOtp.verifyOTP(otp: otp) == true) {
      Get.snackbar('OTP verify', 'Successfully', snackPosition: SnackPosition.TOP);
      return true;
    } else {
      Get.snackbar('OTP verify', 'field', snackPosition: SnackPosition.TOP);
      return false;
    }
  }
}
