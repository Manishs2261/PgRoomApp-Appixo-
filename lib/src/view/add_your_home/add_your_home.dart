import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/view/add_new_screen/add_new_screen.dart';

class AddYourHome extends StatefulWidget {
  const AddYourHome({super.key});

  @override
  State<AddYourHome> createState() => _AddYourHomeState();
}

class _AddYourHomeState extends State<AddYourHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: mediaQuery.width * .8,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewRoom()));
              },
              child: Text("Add New"),),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: 12,
                itemBuilder:(context,index){
                  return Text("hool");
                }),
          )

        ],
      ),
    );
  }
}
