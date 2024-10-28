import 'package:flutter/material.dart';

class FourthFoodForm extends StatefulWidget {
  const FourthFoodForm({super.key});

  @override
  State<FourthFoodForm> createState() => _FourthFoodFormState();
}

class _FourthFoodFormState extends State<FourthFoodForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fourth food form"),
      ),
    );
  }
}
