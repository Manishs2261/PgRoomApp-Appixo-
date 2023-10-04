import 'package:flutter/material.dart';
import 'package:pgroom/src/view/auth_screen/otp_phone_screen/otp_phone_screen.dart';

import '../../../uitels/image_string/image_string.dart';

class ForgetPasswordPhoneNumberScreen extends StatefulWidget {
  const ForgetPasswordPhoneNumberScreen({super.key});

  @override
  State<ForgetPasswordPhoneNumberScreen> createState() => _ForgetPasswordPhoneNumberScreenState();
}

class _ForgetPasswordPhoneNumberScreenState extends State<ForgetPasswordPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(),
        body: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image(image: AssetImage(loginImage,),width: 150,height: 150,fit:
              BoxFit.cover,),
              Text("Forget Password",style: TextStyle(fontSize: 30,fontWeight:
              FontWeight
                  .w400,letterSpacing: 1),),
              Text("Type in your register phone number below to receive a "
                  "reset "
                  "password OTP.",style:
              TextStyle
                (fontSize: 16),),

              SizedBox(height: 50,),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter Registed phone number",
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  contentPadding: EdgeInsets.only(top: 5),
                ),
              ),

              SizedBox(height: 50,),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpPhoneNumberScreen()));
                  },
                  child: Text("Sent Otp"),
                ),
              ),

            ],
          ),
        )

    );
  }
}
