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
                          'We are thrilled to announce that our app is currently in testing mode, and we are dedicated to providing a seamless experience for our users. This phase is crucial as we fine-tune the app’s features and performance to ensure it meets your needs. During this time, your feedback is invaluable, and we encourage you to share any suggestions or report any issues you may encounter.If you need assistance or have any questions, our dedicated support team is here to help. Please feel free to reach out to us via email at',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(
                    text: ' Help.appixo@gmail.com',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  TextSpan(text: ' or call us at', style: TextStyle(color: Colors.black, fontSize: 18)),
                  TextSpan(
                    text: ' +91 80839 31811',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  TextSpan(
                    text: 'We are committed to addressing any concerns and ensuring your experience is smooth and enjoyable.',
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
