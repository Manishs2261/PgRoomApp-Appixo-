import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/repositiry/auth_apis/auth_apis.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/home/home_screen.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {


  final globleKey = GlobalKey<FormState>();

  final TextEditingController _emailControllersing = TextEditingController();
  final TextEditingController _passwordControllersing = TextEditingController();


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
                    controller: _emailControllersing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Email id ",
                      prefixIcon: Icon(Icons.email_outlined),
                      contentPadding: EdgeInsets.only(top: 5),
                     suffix: InkWell(
                       onTap: (){
                         print("send otp ");
                       },
                         child: Text("| SEND OTP   ")),
                      suffixStyle: TextStyle(fontSize: 15,fontWeight:
                      FontWeight.w500,color: Colors.blue)

                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordControllersing,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.password),
                      contentPadding: EdgeInsets.only(top: 5),

                        suffix:
                        (false)
                        ? InkWell(
                            onTap: (){
                              print("send otp ");
                            },
                            child: Text("| Submit   ",style: TextStyle(color:
                            Colors.green),))
                            :
                        InkWell(
                            onTap: (){
                              print("send otp ");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.verified,color: Colors.green,
                                  ),
                            ),),

                    ),
                  ),
                  if(true)
                  SizedBox(height: 15,),
                  if(true)
                  TextFormField(
                    decoration: InputDecoration(
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ,
                      hintText: "Enter Name",
                      prefixIcon: Icon(Icons.person),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  if(true)
                  SizedBox(height: 15,),
                  if(true)
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ,
                      hintText: "Enter city name",
                      prefixIcon: Icon(Icons.location_city),
                      contentPadding: EdgeInsets.only(top: 5),
                    ),
                  ),
                  SizedBox(height: 40,),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {

                        print(_passwordControllersing.text);
                        print(_emailControllersing.text);






                      // AuthApisClass.singEmailIdAndPassword(
                      //     _emailControllersing.text,
                      //     _passwordControllersing.text);

                      },
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

                  SizedBox(height: 50,)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
