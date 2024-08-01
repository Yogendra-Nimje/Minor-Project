import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Title : Find.in (Job Search)",
              style: TextStyle(
                fontSize: 30,
            ),
            ),
          ),
        ],
      ),
    );
  }
}
