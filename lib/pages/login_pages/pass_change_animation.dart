import 'package:find_in/componants/fade_animetion.dart';
import 'package:find_in/pages/login_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangeAnimationPage extends StatefulWidget {
  const ChangeAnimationPage({super.key});

  @override
  State<ChangeAnimationPage> createState() => _ChangeAnimationPageState();
}

class _ChangeAnimationPageState extends State<ChangeAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              //lottie file animetion
              LottieBuilder.asset("lib/assets/ticker.json"),

              const FadeInAnimation(
                delay: 0.6,
                child: Text(
                  "Password Changed!",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const FadeInAnimation(
                delay: 1,
                child: Text(
                  "Your password has been changed successfully",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Urbanist-Bold",
                      fontWeight: FontWeight.w300,
                      color: Colors.grey
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              FadeInAnimation(
                delay: 1.4,
                child:ElevatedButton(
                  //pressed on to change password animation screen
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage ()));
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
                    'Go To Login!',
                    style: TextStyle(fontSize: 18.0,color: Colors.grey[100]),
                  ),
                ),
              ),
            ],
        ),
        ),
      ),
    );
  }
}
