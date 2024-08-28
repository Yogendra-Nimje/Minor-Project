import 'package:find_in/pages/login_pages/login_page.dart';
import 'package:flutter/material.dart';

import '../componants/fade_animetion.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
          children: [
            // Background shapes
            Positioned(
                top: -70,
                  right: 40,
                  child: Container(
                    width: 460,
                    height: 470,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey
                      )
                    ),
                  ),
              ),
            Positioned(
              top: -30,
              left: 10,
              child: Container(
                width: 550,
                height: 470,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.grey
                    )
                ),
              ),
            ),

            Positioned(
              top: 20,
              left: 125,
              child: CircleAvatar(
                radius: 110,
                backgroundColor: Colors.grey[100],
              ),
            ),
            Positioned(
              top: 230,
              left: 40,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 360,
              left: 240,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 1,
                        child: Text(
                          'Find',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            height: 1.2,
                          ),
                        ),
                      ),
                      FadeInAnimation(
                        delay: 1.5,
                        child: Text(
                          'Your',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            height: 1.2,
                          ),
                        ),
                      ),
                      const FadeInAnimation(
                        delay: 2,
                        child: Text(
                          'Dream',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const FadeInAnimation(
                        delay: 2.5,
                        child: Text(
                          'Job',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                 FadeInAnimation(
                   delay: 3,
                   child: Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 22),
                        ),
                        onPressed: () {
                          // Navigate to the Login page
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '    Get Started',
                              style: TextStyle(fontSize: 22,color: Colors.grey[300]),
                            ),
                            const SizedBox(width: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ),
                   ),
                 ),

              ],
            ),
          ],
        ),
    );
  }
}
