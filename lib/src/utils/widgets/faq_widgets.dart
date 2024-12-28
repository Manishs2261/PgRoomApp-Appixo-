import 'package:flutter/material.dart';

class FAQWidgets extends StatelessWidget {
  final String question;
  final String answer;

  const FAQWidgets({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: Colors.grey.withOpacity(0.15),
        elevation: 0,
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          collapsedShape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answer,
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
