import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:find_in/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        // While waiting for Firebase to check the user state
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If there's an error with the stream
        if (userSnapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text("An error has occurred. Try again later."),
            ),
          );
        }

        // When user is logged in, navigate to HomePage
        if (userSnapshot.hasData && userSnapshot.data != null) {
          return const HomePage();
        }

        // When user is not logged in, navigate to OnboardingScreen (or login screen)
        return const OnboardingScreen();
      },
    );
  }
}
