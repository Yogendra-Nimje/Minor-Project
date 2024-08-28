import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../componants/custom_widgets.dart';
import '../../componants/fade_animetion.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                        ),
                        // style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Don't worry! It occurs. Please enter the email address linked with your account.",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist-Bold",
                            fontWeight: FontWeight.w300,
                            color: Colors.grey
                        )
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Column(
                    children: [
                       FadeInAnimation(
                        delay: 1.9,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(18),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(12)),
                              hintText: "Enter your email",
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: Container(

                        )
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              FadeInAnimation(
                delay: 2.4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            // goto otp Page
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.green[400]
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
