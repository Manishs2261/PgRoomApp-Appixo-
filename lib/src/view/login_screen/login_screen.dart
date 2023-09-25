import 'package:flutter/material.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Sign in",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,letterSpacing: 2),),
          Text("Welcome  To ",style: TextStyle(fontSize: 16,letterSpacing: 1,),),
          SizedBox(height: mediaQuery.height * .2,),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(loginGoogleImage),height: 30,width: 30,),
                  SizedBox(width: 15,),
                  Text("Continue with Google",style: TextStyle(fontSize: 18),)
                ],
              ),),
          ),
          SizedBox(height: 15,),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone,size: 30,),
                  SizedBox(width: 15,),
                  Text("Use Phone Number",style: TextStyle(fontSize: 18),)
                ],
              ),),
          )

        ],
        ),
      ),
    );
  }
}
