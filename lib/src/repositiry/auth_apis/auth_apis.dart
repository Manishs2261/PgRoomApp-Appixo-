import 'dart:developer';

import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';


import '../../view/home/home_screen.dart';

class AuthApisClass {


  static EmailOTP myauth = EmailOTP();


  // =======google sing =============
 static handleGoogleButttonClicke(){
   signInWithGoogle().then((value) {
      log('\nUser :${value.user}');
      log('\nyser Additional information :${value.additionalUserInfo}');
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

 static singEmailIdAndPassword(String email , pass) async {
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: pass,
     );
     print("susscefule sign");

   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }

 }

// ======login with email id and password====

static loginEmailAndPassword(String email,String pass) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass
    );

    print("login sussceful");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
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
  static Future<bool> sendEmailOtpVerification( String email) async {

    //====send otp code ==========
    myauth.setConfig(

      appEmail: "sahusanju138@gmail.com",
      appName: "Email OTP by manish",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );
    if (await myauth.sendOTP() == true) {
      Get.snackbar(
          'Send OTP',
          'Successfully ',
          snackPosition: SnackPosition.TOP
      );
      return true;
    } else {
      Get.snackbar(
          'Failed',
          'otp send is failed',
          snackPosition: SnackPosition.TOP
      );
      return false;

    }
  }

  //=========== otp verification code=============

  static Future<bool> otpSubmitVerification(String otp) async {

    if (await myauth.verifyOTP(otp: otp)
    == true) {
      Get.snackbar(
          'OTP',
          'Successfully  verify',
          snackPosition: SnackPosition.TOP
      );
      return true;

    } else {
      Get.snackbar(
          'OTP',
          'faield verification',
          snackPosition: SnackPosition.TOP
      );
      return false;
    }

  }




 static phoneOtpVerification(){

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