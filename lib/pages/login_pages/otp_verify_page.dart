import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../componants/fade_animetion.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(213, 214, 215, 1.0),
      ),
    );
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back,size: 40,),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "OTP Verification",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Enter the verification code we just sent on your email address.",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Urbanist-Bold",
                            fontWeight: FontWeight.w300,
                            color: Colors.grey
                        ),
                      ),
                    ),
                     const SizedBox(height: 20),
                     Form(
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 1.9,
                              child: Pinput(
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                validator: (s) {
                                  return s == '2222' ? null : 'Pin is incorrect';
                                },
                                pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) {
                                  print(pin);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FadeInAnimation(
                              delay: 2.1,
                              child: ElevatedButton(
                                onPressed: () {
                                 // navigate to change password
                                },
                                style: ButtonStyle(
                                    side: const MaterialStatePropertyAll(BorderSide(color: Colors.grey)),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    fixedSize: const MaterialStatePropertyAll(Size.fromWidth(370)),
                                    padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 20),
                                    ),
                                    backgroundColor: const MaterialStatePropertyAll(Colors.green)),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 18.0,color: Colors.grey[100]),
                                ),
                              ),
                            ),
                          ],
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
                                  // goto sign up page
                                  Navigator.pushNamed(context, '/signup');
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
            ],
            ),
          ),
    ),
    );
  }
}
