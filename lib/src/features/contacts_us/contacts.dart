import 'package:flutter/material.dart';

class ContactsUs extends StatelessWidget {
  const ContactsUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ClipOval(
                      child: Image.asset(
                    'assets/images/alok.jpeg', width: 180,
                    // Adjust the width of the circle
                    height: 180,
                    // Adjust the height of the circle
                    fit: BoxFit.fill,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Founder:- Alok aditya",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text("Email Id:- alokaditya.ece@gmail.com"),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              const Column(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: AssetImage('assets/images/manish.jpg'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Co-founder:- Manish sahu",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text("Contact us:- +91 7389523175"),
                  Text("Email Id:- Manishsahu2609@gmail.com"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
