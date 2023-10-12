

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/auth_screen/otp_email_screen/otp_email_screen.dart';
import 'package:pgroom/src/view/auth_screen/otp_phone_screen/otp_phone_screen.dart';
import 'package:pgroom/src/view/auth_screen/sing_in_screen/sing_in_screen.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/on_boarding_screen.dart';

import '../../view/auth_screen/forget_password_email/forget_password.dart';
import '../../view/auth_screen/forget_password_phone_number/forget_password_phone_number.dart';
import '../../view/splash/splash_screen.dart';
import '../route_name/routes_name.dart';

class AppRoutes{

static appRoutes()=>[

  GetPage(name: RoutesName.SplashScreen,
      page: ()=> SplashScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.onboradingScreen, page:()=> OnBoardingOneScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.loginScreen, page:()=> LoginScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.singScreen, page:()=> SingInScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.emailForgetPassScreen, page:()=> ForgetPasswordEmailScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),



  GetPage(name: RoutesName.phoneForgetPassScreen, page:()=> ForgetPasswordPhoneNumberScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.phoneForgetPassScreen, page:()=> ForgetPasswordPhoneNumberScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.otpPhoneforgetPassScreen, page:()=> OtpPhoneNumberScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.otpEmailforgetPassScreen, page:()=> OtpEmailScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),



  GetPage(name: RoutesName.homeScreen, page:()=> HomeScreen(),
  transitionDuration: Duration(milliseconds: 250),
  transition: Transition.leftToRightWithFade),



];

}