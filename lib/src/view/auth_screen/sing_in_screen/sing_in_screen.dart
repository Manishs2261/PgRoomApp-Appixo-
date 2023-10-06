import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {


  final globleKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage(loginImage),height: 150,width: 150,fit:
              BoxFit.cover,),
              Text("Sing-in",style: TextStyle(fontSize: 30,fontWeight: FontWeight
                  .w400,letterSpacing: 1),),
              SizedBox(height: 20,),
              Form(
                  key: globleKey,
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Your Name",
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter phone Number",
                      prefixIcon: Icon(Icons.phone_android_outlined),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Email id ",
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.password),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 40,),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text("Submit"),
                    ),
                  ),
                  SizedBox(height: 20,),

                  // =======Dont have an account button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Alreday have an account ? "),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context)=> LoginScreen()));
                          },
                          child: Text("Sign-in",style: TextStyle(color: Colors
                              .blue),))
                    ],),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
