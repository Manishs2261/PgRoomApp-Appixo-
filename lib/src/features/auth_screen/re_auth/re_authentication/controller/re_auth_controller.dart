import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import '../../../../../data/repository/auth_apis/auth_apis.dart';

class ReAuthScreenController extends GetxController {
  final emailControllerLogin = TextEditingController().obs;
  final passwordControllerLogin = TextEditingController().obs;
  Connectivity connectivity = Connectivity();

  RxBool wrongPassword = false.obs;
  RxBool passView = true.obs;
  RxBool loading = false.obs;

  onReAuthButton(BuildContext context) async {
    await connectivity.checkConnectivity().then((value) {
      // ignore: unrelated_type_equality_checks
      if (value == ConnectivityResult.none) {
        AppHelperFunction.showSnackBar("Please Check Your Internet Connection");
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            });

        loading.value = true;
        AuthApisClass.reAuthAndDeleteAccount(emailControllerLogin.value.text, passwordControllerLogin.value.text)
            .then((value) async {
          if (value) {
            loading.value = false;
            Navigator.pop(Get.context!);
            Get.snackbar("Re-Authenticating", "successfully");
            Get.toNamed(
              RoutesName.deleteAccountScreen,
            );
          } else {
            loading.value = false;
            Navigator.pop(Get.context!);
          }
        }).onError((error, stackTrace) {
          loading.value = false;
          Navigator.pop(Get.context!);
          Get.snackbar("Please try again","Something went wrong during Google Re-Authenticating.");
          if (kDebugMode) {
            print(error);
          }
          if (kDebugMode) {
            if (kDebugMode) {
              print(stackTrace);
            }
          }
        });
      }
    });
  }
}
