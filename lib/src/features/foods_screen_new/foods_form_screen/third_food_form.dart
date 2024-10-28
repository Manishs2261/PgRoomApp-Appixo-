import 'package:flutter/material.dart';

class ThirdFoodForm extends StatefulWidget {
  const ThirdFoodForm({super.key});

  @override
  State<ThirdFoodForm> createState() => _ThirdFoodFormState();
}

class _ThirdFoodFormState extends State<ThirdFoodForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("third food form"),),
    );
  }
}
