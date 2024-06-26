import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:running_text/running_text.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text(
              "Example",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        body: RunningTextView(
            data: RunningTextModel(
                [
                  "Learn how to find target keywords",
                  "Learn how to find target keywords for any page with our keyword research guide.",
                  "Thanks for using! Follow me for more!"
                ],
                textStyle: const TextStyle(
                    fontSize: 15, overflow: TextOverflow.visible),
                softWrap: false,
                velocity: 50,
                direction: RunningTextDirection.rightToLeft,
                fadeSide: RunningTextFadeSide.both,
                tapEvents: [
                  () {
                    log("Tap 1");
                  },
                  () {
                    log("Tap 2");
                  }
                ], defaultTapEvent: () {
          log("Default tap");
        })),
      ),
    );
  }
}
