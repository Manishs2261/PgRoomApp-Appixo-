import 'package:flutter/material.dart';

import 'container_button.dart';

class BottomChatAndCallWidgets extends StatelessWidget {
  const BottomChatAndCallWidgets({
    super.key,  required this.onTapChat, required this.onTapCall,
  });

  final VoidCallback onTapChat;
  final VoidCallback onTapCall;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ContainerButton(onTap: onTapChat, title: 'Chat Now', color: Colors.amber, textColor: Colors.black,),
          ContainerButton(onTap: onTapCall, title: 'Call Now', color: const Color.fromRGBO(0, 204, 102, 1.0), textColor: Colors.white),

        ],
      ),
    );
  }
}