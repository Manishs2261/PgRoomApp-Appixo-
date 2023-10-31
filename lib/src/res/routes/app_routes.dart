

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/auth_screen/otp_email_screen/otp_email_screen.dart';
import 'package:pgroom/src/view/auth_screen/otp_phone_screen/otp_phone_screen.dart';
import 'package:pgroom/src/view/auth_screen/sing_in_screen/sing_in_screen.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_screen/edit_form_screen.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/on_boarding_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/add_image_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/charges_and_door_timing/charges_and_door_timing_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/hostel_and_room_type_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/permission/permission_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/provide_facilites_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details/rent_details_screen.dart';

import '../../view/add_new_home/add_your_home.dart';
import '../../view/auth_screen/forget_password_email/forget_password.dart';
import '../../view/auth_screen/forget_password_phone_number/forget_password_phone_number.dart';
import '../../view/details_rent_screen/details_rent_screen.dart';
import '../../view/edit_add_new_home/edit_add_new_home.dart';
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


  GetPage(name: RoutesName.rentDetails_screen, page:()=> RentDetailsScsreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.addYourHomeScreen, page:()=>AddYourHome() ,
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.addImageScreen, page:()=> AddImageScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.chargeAndDoorTimingScreen, page:()=> ChargesAndDoorTime(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.hostelAndRoomTypeScreen, page:()=> HostelAndRoomTypeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.perimissionScreen, page:()=> PermissioinScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.providsFacilitesScreen, page:()=> ProvideFacilitesScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.rentDetailsFormScreen, page:()=> RentDetailsScsreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.detailsRentInfoScreen, page:()=> DetailsRentInfoScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editAddNewHome_Screen, page:()=>  EditAddNewHomeScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.editFormScreen, page:()=>  EditFormScreen(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

];

}