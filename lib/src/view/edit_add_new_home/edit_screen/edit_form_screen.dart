import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/add_image_screen.dart';

class EditFormScreen extends StatefulWidget {
  const EditFormScreen({super.key});

  @override
  State<EditFormScreen> createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit"),),
      body: SingleChildScrollView(
        child: Column(

          children: [



          ],
        ),
      ),
    );
  }
}
