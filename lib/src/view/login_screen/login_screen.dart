import 'package:flutter/material.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final globleKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(

  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(loginImage,),width: 150,height: 150,fit:
            BoxFit.cover,),
            Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight
                .w400,letterSpacing: 1),),
            Text("Welcome  Back ",style: TextStyle(fontSize: 16,letterSpacing:
            1,),),

            SizedBox(height: 50,),
              Form(
                key: globleKey,
                  child: Column(
                children: [

                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Email id or Number",
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                ],
              )),
            Align(
              heightFactor: 2,
              alignment: Alignment.centerRight,
                child: Text("Forget PassWord ",style: TextStyle(color: Colors.blue),)),
            SizedBox(height: 20,),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 15,),
                    Text("Login ",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Don't have an account ? "),
              Text("Sign-up",style: TextStyle(color: Colors.blue),)
            ],),
             Row(
              children: [
                Divider(color: Colors.black,thickness: 10,),
                Text("Or"),
                Divider(color: Colors.black,thickness: 10,),

              ],
            ),

            SizedBox(height: 30,),
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



          ],
          ),
        ),
      ),
    );
  }
}
