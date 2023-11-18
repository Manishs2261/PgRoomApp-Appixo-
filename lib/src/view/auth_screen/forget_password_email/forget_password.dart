import 'package:flutter/material.dart';
import 'package:pgroom/src/view/auth_screen/otp_email_screen/otp_email_screen.dart';

import '../../../uitels/Constants/image_string.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({super.key});

  @override
  State<ForgetPasswordEmailScreen> createState() => _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {


  final globleKey = GlobalKey<FormState>();
  final TextEditingController _emailControlerLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image(image: AssetImage(AppImage.loginImage,),width: 150,height: 150,fit:
            BoxFit.cover,),
            Text("Forget Password",style: TextStyle(fontSize: 30,fontWeight:
            FontWeight
                .w400,letterSpacing: 1),),
            Text("Type in your register e-mail below to receive a reset "
                "password Email.",style:
            TextStyle
              (fontSize: 16),),

            SizedBox(height: 50,),

            Form(
              key: globleKey,
              child: TextFormField(
                controller: _emailControlerLogin,
                validator: (value){
                  if(value == null || value.isEmpty)
                  {
                    return 'Please enter Email id ';
                  }else{
                    return null;
                  }
                },

                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter Registed Email id",
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: EdgeInsets.only(top: 5),
                ),
              ),
            ),

            SizedBox(height: 50,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){

                  if(globleKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context)=> OtpEmailScreen()));
                  }


                },
                child: Text("Sent Otp"),
              ),
            )

          ],
        ),
      )

    );
  }
}
