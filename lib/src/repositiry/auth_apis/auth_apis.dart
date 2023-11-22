import 'dart:developer';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/helpers/heiper_function.dart';
import 'package:pgroom/src/view/splash/controller/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/home/home_screen.dart';

class AuthApisClass {
  static EmailOTP emailOtp = EmailOTP();
  static Connectivity connectivity = Connectivity();
  static bool otpSend = false;

  // =======google sing =============
  static handleGoogleButttonClicke(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar('Please Check Your Internet Connection');
      } else {
        signInWithGoogle().then((value) async {
          // sharedPrefrences code
          SharedPreferences preferences = await SharedPreferences.getInstance();
          //upload user uid data in SharedPreferenses
          preferences.setString('userUid', value.user!.uid);
          // initializ varible
          finalUserUidGloble = preferences.getString('userUid');
          log('\nUser :${value.user}');
          Get.offAllNamed(RoutesName.homeScreen);
        });
      }
    });
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
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Weak Password",
            "This password is weak use Number,"
                "Character");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Email-already-in-use", "This email id is alreday exist", backgroundColor: Colors.redAccent);
        return false;
      }
    } catch (e) {
      Get.snackbar(" sing error", "$e");
    }

    return true;
  }

// ======login with email id and password====

  static Future<bool> loginEmailAndPassword(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);

      print("data lodin 🧧${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("NO user found", "No user found for that email.");

        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
            "Worng password",
            "Wrong password provided for that user"
                ".",
            backgroundColor: Colors.redAccent);

        return false;
      } else {
        Get.snackbar("Error", "In valid Email id and password");
        print(e.code);
        return false;
      }
    }

    return true;
  }

// phone number verification code

  static phoneNUmberVerification() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        //  ForgetPasswordPhoneNumberScreen.verify = verificationId;
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpPhoneNumberScreen()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  //===========send opt email verification ===============
  static Future<bool> sendEmailOtpVerification(String email) async {
    //====send otp code ==========
    emailOtp.setConfig(
      appEmail: "sahusanju138@gmail.com",
      appName: "Email OTP by manish",
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
      Get.snackbar('OTP', 'Successfully  verify', snackPosition: SnackPosition.TOP);
      return true;
    } else {
      Get.snackbar('OTP', 'faield verification', snackPosition: SnackPosition.TOP);
      return false;
    }
  }

  static phoneOtpVerification() {
    //   try{
    //
    //
    //     // Create a PhoneAuthCredential with the code
    //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //         verificationId: ForgetPasswordPhoneNumberScreen.verify,
    //         smsCode: Scode);
    //
    //     // Sign the user in (or link) with the credential
    //     await auth.signInWithCredential(credential).then((value) {
    //
    //       print("login susscefule");
    //       Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    //     });
    //   }
    //       catch(e){
    //     print("error otp : $e");
    //       }
  }
}
