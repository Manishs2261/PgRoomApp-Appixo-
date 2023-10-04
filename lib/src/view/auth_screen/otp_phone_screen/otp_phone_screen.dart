import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../uitels/image_string/image_string.dart';

class OtpPhoneNumberScreen extends StatefulWidget {
  const OtpPhoneNumberScreen({super.key});

  @override
  State<OtpPhoneNumberScreen> createState() => _OtpPhoneNumberScreenState();
}

class _OtpPhoneNumberScreenState extends State<OtpPhoneNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(loginImage,),width: 150,height: 150,fit:
            BoxFit.cover,),
            Text("Verification",style: TextStyle(fontSize: 30,fontWeight:
            FontWeight
                .w400,),),
            Text("Enter the verification code send at  \n 738*****75"),
            SizedBox(height: 50,),

         Pinput(

        validator: (s) {},
           length: 6,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,

      ),
            SizedBox(height: 50,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Submit"),
              ),
            )

          ],
        ),
      ),

    );
  }
}
