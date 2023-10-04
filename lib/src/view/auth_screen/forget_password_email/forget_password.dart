import 'package:flutter/material.dart';

import '../../../uitels/image_string/image_string.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({super.key});

  @override
  State<ForgetPasswordEmailScreen> createState() => _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
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
            Text("Type in your register e-mail below to receive a reset "
                "password Email.",style:
            TextStyle
              (fontSize: 16),),

            SizedBox(height: 50,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Enter Registed Email id",
                prefixIcon: Icon(Icons.email_outlined),
                contentPadding: EdgeInsets.only(top: 5),
              ),
            ),

            SizedBox(height: 50,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Sent Otp"),
              ),
            )

          ],
        ),
      )

    );
  }
}
