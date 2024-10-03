import 'package:find_in/pages/login_pages/login_page.dart';
import 'package:find_in/pages/login_pages/otp_verify_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../componants/custom_widgets.dart';
import '../../componants/fade_animetion.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _forgotPasswordSubmitForm() async {
    try{
      await _auth.sendPasswordResetEmail(
        email: _emailController.text,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
    }catch(error){
      Fluttertoast.showToast(msg: error.toString());
    }
  }

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
                child: Column(
                  children: [
                     FadeInAnimation(
                      delay: 1.9,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          hintText: "Enter your email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade800),
                              borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.green.shade700),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )

                     ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInAnimation(
                      delay: 2.1,
                      child: ElevatedButton(
                        //pressed on to otp page
                          onPressed: () {
                            _forgotPasswordSubmitForm();
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpVerifyPage()));
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
                            'Send Code',
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
      ),
    );
  }
}
