import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
     Container(color: Colors.blue,),
     Container(color: Colors.red,),
     Container(color: Colors.grey,),
     Container(color: Colors.green,),
        ],
      ),
    );
  }
}
