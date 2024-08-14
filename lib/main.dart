import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:find_in/pages/login_page.dart';
import 'package:find_in/pages/sign_up_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/homepage':(context) => HomePage(),
      },
    );
  }
}
