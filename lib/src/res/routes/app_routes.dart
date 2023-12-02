

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pgroom/src/features/rent_form_screen/provide_facilities/provide_facilities_screen.dart';


import '../../features/add_new_home/add_your_home.dart';
import '../../features/auth_screen/forget_password_email/forget_password.dart';
import '../../features/auth_screen/forget_password_phone_number/forget_password_phone_number.dart';
import '../../features/auth_screen/login_screen/login_screen.dart';
import '../../features/auth_screen/otp_email_screen/otp_email_screen.dart';
import '../../features/auth_screen/otp_phone_screen/otp_phone_screen.dart';
import '../../features/auth_screen/sing_in_screen/sing_in_screen.dart';
import '../../features/details_rent_screen/details_rent_screen.dart';
import '../../features/edit_add_new_home/edit_add_new_home.dart';
import '../../features/edit_add_new_home/edit_screen/edit_form_screen_button.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/Edit_Cover_Image_Screen.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/add_other_image/add_other_image.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/edit_charges.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/edit_permission.dart';

 import '../../features/edit_add_new_home/edit_screen/edit_screen/edit_provid_facilities.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/edit_rent_text_details.dart';
import '../../features/edit_add_new_home/edit_screen/edit_screen/room_and_price.dart';
import '../../features/home/home_screen.dart';
import '../../features/on_boarding_screen/on_boarding_screen.dart';
import '../../features/rent_form_screen/add_image_/add_image_screen.dart';
import '../../features/rent_form_screen/charges_and_door_timing/charges_and_door_timing_screen.dart';
import '../../features/rent_form_screen/hostel_and_room_type/hostel_and_room_type_screen.dart';
import '../../features/rent_form_screen/permission/permission_screen.dart';
 import '../../features/rent_form_screen/rent_details/rent_details_screen.dart';
import '../../features/search/search.dart';
import '../../features/splash/splash_screen.dart';

import '../../features/view_all_image/view_all_image.dart';
import '../../features/view_all_review/view_all_review.dart';
import '../route_name/routes_name.dart';

class AppRoutes{

static appRoutes()=>[

  GetPage(name: RoutesName.SplashScreen,
      page: ()=> SplashScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.onboradingScreen, page:()=> const OnBoardingOneScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.loginScreen, page:()=> LoginScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.singScreen, page:()=> SingInScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.emailForgetPassScreen, page:()=> const ForgetPasswordEmailScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),



  GetPage(name: RoutesName.phoneForgetPassScreen, page:()=> const ForgetPasswordPhoneNumberScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.phoneForgetPassScreen, page:()=> const ForgetPasswordPhoneNumberScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.otpPhoneforgetPassScreen, page:()=>  OtpPhoneNumberScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.otpEmailforgetPassScreen, page:()=>  OtpEmailScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),



  GetPage(name: RoutesName.homeScreen, page:()=> HomeScreen(),
  transitionDuration: const Duration(milliseconds: 250),
  transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.rentDetails_screen, page:()=> RentDetailsScsreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.addYourHomeScreen, page:()=>const AddYourHome() ,
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.addImageScreen, page:()=> AddImageScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.chargeAndDoorTimingScreen, page:()=> ChargesAndDoorTime(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.hostelAndRoomTypeScreen, page:()=> HostelAndRoomTypeScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.perimissionScreen, page:()=> PermissioinScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.provideFacilitiesScreen, page:()=> ProvideFacilitiesScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.rentDetailsFormScreen, page:()=> RentDetailsScsreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.detailsRentInfoScreen, page:()=> DetailsRentInfoScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editAddNewHome_Screen, page:()=>  EditAddNewHomeScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.editFormScreen, page:()=>  EditFormScreenButton(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.editRentDetailScreen, page:()=>  EditRentTextDetailsScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editRoomTyprAndPriceScreen, page:()=>  EditRoomTypeAndPrice(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editFaciliteProviderScreen, page:()=>  EditProvideFacilites(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editChargesScreen, page:()=>  EditAdditionalChargesAndDoorTime(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


  GetPage(name: RoutesName.editPermissionScreen, page:()=>  EditPermissiionScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editImagesScreen, page:()=>  EditCoverImageScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.searchScreen, page:()=>  const SearchScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.viewAllReview, page:()=>  ViewAllReviewScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.viewALlImage, page:()=>  ViewAllImage(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),

  GetPage(name: RoutesName.editOtherImageScareen, page:()=> EditOtherImageScreen(),
      transitionDuration: const Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade),


];

}


