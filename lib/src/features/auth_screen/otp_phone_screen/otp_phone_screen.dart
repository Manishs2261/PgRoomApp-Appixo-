import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import '../../../utils/Constants/image_string.dart';

class OtpPhoneNumberScreen extends StatelessWidget {
   OtpPhoneNumberScreen({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  var code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(AppImage.loginImage,),width: 150,height: 150,fit:
            BoxFit.cover,),
            Text("Verification",style: TextStyle(fontSize: 30,fontWeight:
            FontWeight
                .w400,),),
            Text("Enter the verification code send at  \n 738*****75"),
            SizedBox(height: 50,),


         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Pinput(
             length: 6,
      // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,

             onChanged: (value){
               code = value;
             },

      ),
         ),
            SizedBox(height: 50,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {



                },
                child: Text("Submit"),
              ),
            )

          ],
        ),
      ),

    );
  }
}
