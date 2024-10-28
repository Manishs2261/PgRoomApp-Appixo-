import 'package:flutter/material.dart';

class SecondFoodForm extends StatefulWidget {
  const SecondFoodForm({super.key});

  @override
  State<SecondFoodForm> createState() => _SecondFoodFormState();
}

class _SecondFoodFormState extends State<SecondFoodForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondFoodForm"),),
    );
  }
}
