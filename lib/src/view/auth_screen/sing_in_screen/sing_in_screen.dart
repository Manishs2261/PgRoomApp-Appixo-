import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/repositiry/auth_apis/auth_apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/Constants/image_string.dart';
import 'package:pgroom/src/uitels/validator/text_field_validator.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/auth_screen/sing_in_screen/sing_screen_controller/sing_screen_controller.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});

  final globleKey = GlobalKey<FormState>();

  final _controller = Get.put(SingScsreenController());

  @override
  Widget build(BuildContext context) {
    print("rebuild => sing screen 🧧");
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        // ======on tab off the keybord screen
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(AppImage.loginImage),
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Sing-in",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: globleKey,
                    child: Column(
                      children: [
                        //=========enter email text field =============
                        Obx(
                          () => TextFormField(
                            controller: _controller.emailControllersing.value,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            validator: EmailValidator.validate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                hintText: "Enter Email id ",
                                prefixIcon: Icon(Icons.email_outlined),
                                contentPadding: EdgeInsets.only(top: 5),
                                //=====send the otp text buttton ==========
                                suffix:

                                    /// in there have two condition
                                    ///first condition
                                    ///if otp is verified than remove a SEND
                                    /// otp
                                    /// text button and re_send text button
                                    /// second condition
                                    ///send opt and resend otp button
                                    /// first condition
                                    Obx(
                                  () => (_controller.isVerify.value)
                                      ? Text("")
                                      // second condition
                                      : (_controller.isSend.value)
                                          ? Obx(
                                              () => (_controller.counter.value != 0)
                                                  ? Obx(
                                                      () => Padding(
                                                        padding: const EdgeInsets.only(right: 22),
                                                        child: Text("${_controller.counter.value}"),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        ///====RE- send otp code

                                                        if (_controller.emailControllersing.value.text == "") {
                                                          return null;
                                                        } else {
                                                          _controller.onReSendOtpButton(context);
                                                        }
                                                      },
                                                      child: Obx(
                                                        () => (_controller.otpLoading.value)
                                                            ? Padding(
                                                                padding: const EdgeInsets.only(right: 20),
                                                                child: SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: CircularProgressIndicator(
                                                                    color: Colors.blue,
                                                                    strokeWidth: 3,
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                "| RE-SEND   ",
                                                                style: TextStyle(
                                                                  color: Colors.green,
                                                                ),
                                                              ),
                                                      )),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                //====send otp code ==========

                                                if (_controller.emailControllersing.value.text == "") {
                                                  print("email is empty");

                                                  return null;
                                                } else {
                                                  print("email");

                                                  _controller.onSendOtpButton(context);
                                                }
                                              },
                                              child: Obx(
                                                () => (_controller.otpLoading.value)
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(right: 20),
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            color: Colors.blue,
                                                            strokeWidth: 3,
                                                          ),
                                                        ),
                                                      )
                                                    : Text("| "
                                                        "SEND OTP   "),
                                              )),
                                ),
                                suffixStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue)),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        //========enter otp text field =============
                        TextFormField(
                          controller: _controller.otpControllersing.value,
                          keyboardType: TextInputType.number,
                          validator: OtpValidator.validate,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter OTP",
                              prefixIcon: Icon(Icons.password),
                              contentPadding: EdgeInsets.only(top: 5),
                              suffix: Obx(
                                () => (_controller.isOtp.value)
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.green,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          //============verify otp
                                          // controller mathods ===========

                                          await _controller.connectivity.checkConnectivity().then((value) {
                                            if (value == ConnectivityResult.none) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: const Text('Please Check Your Internet Connection '),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            } else {
                                              if (_controller.otpControllersing.value.text == "") {
                                                return null;
                                              } else {
                                                _controller.onOtpSubmitController();
                                              }
                                            }
                                          });
                                        },
                                        child: Text(
                                          "| Submit   ",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                              )),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        // ===========Enter Password text fied =============
                        Obx(
                          () => (_controller.isOtp.value)
                              ? TextFormField(
                                  controller: _controller.passwordControllersing.value,
                                  keyboardType: TextInputType.text,
                                  validator: PasswordValidator.validate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    hintText: "Enter min 6 cgaracter of  password",
                                    prefixIcon: Icon(Icons.lock),
                                    contentPadding: EdgeInsets.only(top: 5),
                                  ),
                                )
                              : Text(""),
                        ),

                        Obx(
                          () => (_controller.isOtp.value)
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                        ),

                        Obx(
                          () => (_controller.isOtp.value)
                              ? //===========enter name text field ================
                              TextFormField(
                                  controller: _controller.nameControllersing.value,
                                  keyboardType: TextInputType.text,
                                  validator: NameValidator.validate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    hintText: "Enter Name",
                                    prefixIcon: Icon(Icons.person),
                                    contentPadding: EdgeInsets.only(top: 5),
                                  ),
                                )
                              : Text(""),
                        ),
                        Obx(
                          () => (_controller.isOtp.value)
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                        ),

                        Obx(
                          () => (_controller.isOtp.value)
                              //=============enter city name text field =============
                              ? TextFormField(
                                  controller: _controller.citynameontrollersing.value,
                                  keyboardType: TextInputType.text,
                                  validator: CityValidator.validate,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    hintText: "Enter city name",
                                    prefixIcon: Icon(Icons.location_city),
                                    contentPadding: EdgeInsets.only(top: 5),
                                  ),
                                )
                              : Text(""),
                        ),

                        Obx(
                          () => (_controller.isOtp.value)
                              ? SizedBox(
                                  height: 15,
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //===========submit button ===============
                        Obx(
                          () => SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (globleKey.currentState!.validate()) {
                                  await _controller.connectivity.checkConnectivity().then((value) {
                                    if (value == ConnectivityResult.none) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Please Check Your Internet Connection '),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      _controller.onSubmitButton();
                                    }
                                  });
                                }
                              },
                              child: (_controller.loading.value)
                                  ? CircularProgressIndicator(
                                      color: Colors.blue,
                                    )
                                  : Text("Submit"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // =======Dont have an account button=========
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Alreday have an account ? "),
                            InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "Sign-in",
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),

                        SizedBox(
                          height: 50,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
