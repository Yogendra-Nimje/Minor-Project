

import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:find_in/pages/login_pages/login_page.dart';
import 'package:find_in/pages/login_pages/sign_up_page.dart';
import 'package:find_in/pages/splash_screen.dart';
import 'package:find_in/theme/theme_provide.dart';
import 'package:find_in/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Find In App id being initialized",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }
        else if(snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("An error has been occurred",
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Auth',
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: const UserState(),
          /*initialRoute: '/',
          routes: {
            '/': (context) => const OnboardingScreen(),
            '/signup': (context) => SignUpPage(),
            '/homepage':(context) => const HomePage(),
          },*/
        );
      },
    );
  }
}
