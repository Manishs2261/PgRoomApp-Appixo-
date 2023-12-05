import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/data/repository/auth_apis/auth_apis.dart';
import 'package:pgroom/src/features/auth_screen/forget_password_email/controller/controller.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/app_validators/app_validators.dart';
import 'package:pgroom/src/utils/validator/text_field_validator.dart';

import '../../../utils/Constants/image_string.dart';

class ForgetPasswordEmailScreen extends StatelessWidget {
  ForgetPasswordEmailScreen({super.key});

  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage(
                  AppImage.loginImage,
                ),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              Text(
                "Forget Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 1),
              ),
              Text(
                "Type in your register e-mail below to receive a reset "
                "password Email.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: controller.globalKey.value,
                child: TextFormField(
                  controller: controller.emailControlerLogin.value,
                  keyboardType: TextInputType.text,
                  validator: (value) => AppValidator.validateEmail(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Registed Email id",
                    prefixIcon: Icon(Icons.email_outlined),
                    contentPadding: EdgeInsets.only(top: 5),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
             ComReuseElevButton(onPressed: ()=> controller.sendEmailForgetPassword(), title: "Submit")

            ],
          ),
        ));
  }
}
