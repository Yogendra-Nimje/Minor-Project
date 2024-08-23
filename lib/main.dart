

import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:find_in/pages/login_page.dart';
import 'package:find_in/pages/sign_up_page.dart';
import 'package:find_in/pages/splash_screen.dart';
import 'package:find_in/theme/theme_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/signup': (context) => SignUpPage(),
        '/homepage':(context) => const HomePage(),
      },
    );
  }
}
