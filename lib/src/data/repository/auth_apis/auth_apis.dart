import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

 import '../../../features/splash/controller/splash_controller.dart';
import '../apis/room_collection.dart';
import '../apis/user_collection.dart';

class AuthApisClass {
  static EmailOTP emailOtp = EmailOTP();

  static bool otpSend = false;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> handleGoogleButtonClick(BuildContext context) async {
    try {
      // 1. Start Google Sign-In process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 2. Authenticate with Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      AppLoggerHelper.info(user!.uid);

      if (await UserApis.checkUserUidExit(user.uid)) {
        UserApis.setSharedPreferences(uid: user.uid);
        Get.offAllNamed(RoutesName.homeNew);
      } else {
        Get.offAllNamed(RoutesName.signProfileScreen,
            arguments: {'email': user.email});
      }
    } catch (e) {
      AppLoggerHelper.error("Error during Google Sign-In", e);
    }
  }

  // =======google sing =============
  // static handleGoogleButtonClick(BuildContext context) async {
  //   AppHelperFunction.checkInternetAvailability().then((value) {
  //     if (value) {
  //       signInWithGoogle().then((value) async {
  //         // await UserApis.saveUserData(auth.currentUser?.displayName, "",
  //         //     auth.currentUser?.email, auth.currentUser!.photoURL);
  //
  //         AppLoggerHelper.info(UserApis.userName);
  //        //  if (UserApis.userName != '') {
  //        //    Navigator.of(Get.context!).pushAndRemoveUntil(
  //        //        MaterialPageRoute(
  //        //            builder: (context) => const HomeNew()),
  //        //        (Route<dynamic> route) => false);
  //        //  } else {
  //        //    Get.offAllNamed(RoutesName.signProfileScreen,
  //        //        arguments: {'email': auth.currentUser?.email});
  //        //  }
  //        //
  //        // // sharedPreferences code
  //        //  SharedPreferences preferences = await SharedPreferences.getInstance();
  //        //  //upload user uid data in SharedPreferences
  //        //  preferences.setString('userUid', value.user!.uid);
  //        //  // initialize variable
  //        //  finalUserUidGlobal = preferences.getString('userUid');
  //        //  log('\nUser :${value.user}');
  //        //  Get.offAllNamed(RoutesName.homeNew);
  //       });
  //     }
  //   });
  // }

  //check for user login or not
  static Future<bool> checkUserLogin() async {
    if (ApisClass.auth.currentUser?.uid == finalUserUidGlobal) {
      return true;
    } else {
      Get.defaultDialog(
          title: "Login please",
          middleText: "You are not login?.",
          actions: [
            SizedBox(
              height: 40,
              width: AppHelperFunction.screenWidth() * 0.4,
              child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(RoutesName.loginScreen);
                  },
                  child: const Text("Login")),
            )
          ]);
      return false;
    }
  }

  //====================== google sign=========================
  static Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the sign-in was successful
      if (googleUser == null) {
        // If signIn() returns null, the user canceled the sign-in process
        Get.snackbar("Google sign-in", "Google sign-in was canceled.");
        throw Exception('Google sign-in was canceled.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      AppLoggerHelper.error(e.toString());
      Get.snackbar("Google sign-in",
          "Something went wrong during Google sign-in. Please try again.");
      throw Exception(
          'Something went wrong during Google sign-in. Please try again.');
    }
  }

  //================= ReAuthenticate a user====================================

  // Google sign-in and re-authentication method
  static Future<void> reAuthenticateInWithGoogle() async {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });

    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        Navigator.pop(Get.context!);
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Re-authenticate the user with the new credential
      await auth.currentUser?.reauthenticateWithCredential(credential);
      Navigator.pop(Get.context!);
      Get.snackbar("Re-authentication", "Re-authentication successful");
      Get.toNamed(RoutesName.deleteAccountScreen);
      // Handle successful re-authentication
      if (kDebugMode) {
        print('Re-authentication successful');
      }
      // TODO: Update UI or perform any necessary actions after re-authentication
    } catch (e) {
      // Handle errors
      Navigator.pop(Get.context!);
      Get.snackbar("Re-authentication", "Re-authentication Failed");
      if (kDebugMode) {
        print('Error during re-authentication: $e');
      }
      // TODO: Update UI to show error message or take appropriate actions
    }
  }

  //====sing with email and password==========

  static Future<bool> singEmailIdAndPassword(String email, String pass) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final user = credential.user;
      await FirebaseAuth.instance.setLanguageCode("en");
      await user?.sendEmailVerification();

      AppLoggerHelper.info("${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
            "Weak Password",
            "This password is weak use Number,"
                "Character");
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print(e.code);
        }
        Get.snackbar("Email-already-in-use", "This email id is already exist");
        return false;
      }
    } catch (e) {
      Get.snackbar(" InValid", "Sign");
      AppLoggerHelper.info(" api $e , = $e");
    }

    return true;
  }

// ======login with email id and password====

  static Future<bool> loginEmailAndPassword(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      if (credential.user!.emailVerified) {
        return true;
      } else {
        Get.snackbar("Email Not Verified", "The email has not been verified..");
      }

      AppLoggerHelper.info("login - ${credential.user}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("NO User found", "User are not registered.");

        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar("InValid", "password");

        return false;
      } else {
        Get.snackbar("Invalid", "Email id and password");
        AppLoggerHelper.info(e.code);
        return false;
      }
    }

    return false;
  }

  // //===========send opt email verification ===============
  // static Future<bool> sendEmailOtpVerification(String email) async {
  //   //====send otp code ==========
  //   emailOtp.setConfig(
  //     appEmail: "sahusanju138@gmail.com",
  //     appName: "~ By Appixo   ",
  //     userEmail: email,
  //     otpLength: 6,
  //     otpType: OTPType.digitsOnly,
  //   );
  //   if (await emailOtp.sendOTP() == true) {
  //     otpSend = true;
  //     return true;
  //   } else {
  //     otpSend = false;
  //     return false;
  //   }
  // }

  //=========== otp verification code=============

  // static Future<bool> otpSubmitVerification(String otp) async {
  //   if (await emailOtp.verifyOTP(otp: otp) == true) {
  //     Get.snackbar('OTP verify', 'Successfully',
  //         snackPosition: SnackPosition.TOP);
  //     return true;
  //   } else {
  //     Get.snackbar('OTP verify', 'Failed', snackPosition: SnackPosition.TOP);
  //     return false;
  //   }
  // }

  // ============Forget Password ==========

  static forgetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email).then((value) {
      Get.snackbar("Send Email", "check your Email id.");
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
    }).onError((error, stackTrace) {
      Get.snackbar("Send Email", "Failed.");
      Navigator.pop(Get.context!);
      if (kDebugMode) {
        print(error);
      }
      if (kDebugMode) {
        print(stackTrace);
      }
    });
  }

// ======login with email id and password====

  static Future<bool> reAuthAndDeleteAccount(String email, String pass) async {
    try {
      // Sign in the user with email and password to get the credential
      final credential =
          EmailAuthProvider.credential(email: email, password: pass);
      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);

      // // Delete the user account
      // await FirebaseAuth.instance.currentUser?.delete();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar(
            "Invalid Password", "The password you entered is incorrect.");
      }
      if (e.code == 'invalid-credential') {
        Get.snackbar("Invalid", "Email id and password");
      } else {
        Get.snackbar("Invalid", "Email id and password");
        if (kDebugMode) {
          print("Error: ${e.code}");
        }
      }
      return false;
    }
  }
}
