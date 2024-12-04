import 'package:flutter/material.dart';

class SecondServicesForm extends StatefulWidget {
  const SecondServicesForm({super.key});

  @override
  State<SecondServicesForm> createState() => _SecondServicesFormState();
}

class _SecondServicesFormState extends State<SecondServicesForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second service form"),),
    );
  }
}
