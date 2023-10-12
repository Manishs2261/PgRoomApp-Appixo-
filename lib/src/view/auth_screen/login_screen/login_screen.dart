import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/repositiry/auth_apis/auth_apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/auth_screen/forget_password_phone_number/forget_password_phone_number.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen_controller/login_controller.dart';
import 'package:pgroom/src/view/auth_screen/sing_in_screen/sing_in_screen.dart';
import 'package:pgroom/src/view/home/home_screen.dart';

import '../forget_password_email/forget_password.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final globleKey = GlobalKey<FormState>();

  final _controller = Get.put(LoginScreenController());
   final emailControlerLogin = TextEditingController();
   final passwordControlerLogin = TextEditingController();


   @override
  Widget build(BuildContext context) {
    print("rebUild => login screen 🔴");
    return Scaffold(
      appBar: AppBar(
        //=======skip buttton ========
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
                onTap: () {
               Get.offAllNamed(RoutesName.homeScreen);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ],
      ),
      body: GestureDetector(
        // ======on tab off the keybord screen
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(
                    loginImage,
                  ),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1),
                ),
                Text(
                  "Welcome Back ",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                Form(
                    key: globleKey,
                    child: Column(
                      children: [
                        //===========Email and phone number  text
                        // field===============
                       TextFormField(
                            controller: emailControlerLogin,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email id ';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter Email id ",
                              prefixIcon: Icon(Icons.email_outlined),
                              contentPadding: EdgeInsets.only(top: 5),
                            ),
                          ),

                        SizedBox(
                          height: 15,
                        ),
                        //==========password text field==============
                        Obx(
                          ()=> TextFormField(
                            controller: passwordControlerLogin,
                            obscureText:_controller.passView.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Password ';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon:
                                 (_controller.passView.value)
                                    ? InkWell(
                                        onTap: () {
                                          _controller.passView.value= false;
                                        },
                                        child: Icon(Icons.visibility_off))
                                    : InkWell(
                                        onTap: () {
                                          _controller.passView.value = true;
                                        },
                                        child: Icon(Icons.visibility)),

                              contentPadding: EdgeInsets.only(top: 5),
                            ),
                          ),
                        ),
                      ],
                    )),

                //=======forget password text button=====
                Align(
                    heightFactor: 2,
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.emailForgetPassScreen);
                        },
                        child: Text(
                          "Forget PassWord ",
                          style: TextStyle(color: Colors.blue),
                        ))),
                SizedBox(
                  height: 20,
                ),

                // ===========login button ==============
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Obx(
                      ()=> ElevatedButton(
                      onPressed: () async {

                        if (globleKey.currentState!.validate()) {

                       _controller.loading.value = true;


                          AuthApisClass.loginEmailAndPassword(
                                  emailControlerLogin.text,
                                  passwordControlerLogin.text)
                              .then((value) {
                            //if user use wrong password and email id thna
                            // not to allow next page navigation
                            _controller.worngpassword.value = value;

                          _controller.loading.value = false;
                            if (_controller.worngpassword.value)
                               Get.offAllNamed(RoutesName.homeScreen);
                          });
                        }
                      },
                      child: (_controller.loading.value)
                          ? CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : Text("Login"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // =======Dont have an account button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ? "),
                    InkWell(
                        onTap: () {
                     Get.toNamed(RoutesName.singScreen);
                        },
                        child: Text(
                          "Sign-up",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //=========divider ==================
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    )),
                    Text("  Or  "),
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    )),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                //========continue with google ======
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //google sing code
                      AuthApisClass.handleGoogleButttonClicke();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(loginGoogleImage),
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Continue with Google",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


