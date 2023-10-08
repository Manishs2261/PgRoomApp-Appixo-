import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/home/home_screen.dart';

class AuthApisClass {

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