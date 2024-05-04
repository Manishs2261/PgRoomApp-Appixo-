import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text:
                          'The app is currently in testing mode. If you encounter any issues or need assistance, please reach out to us via email at',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(
                    text: ' Help.appixo@gmail.com',
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                  TextSpan(text: '  or call us at', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(
                    text: ' +91 7389523175',
                    style: TextStyle(color: Colors.blue, fontSize: 22),
                  ),
                  TextSpan(
                    text: '. We are here to help!',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
