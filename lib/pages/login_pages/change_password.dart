import 'package:find_in/componants/fade_animetion.dart';
import 'package:find_in/pages/login_pages/pass_change_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back button
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.back,size: 35,),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Create New Password",
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
                          "Your New password must be unique from those previously used.",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Urbanist-Bold",
                              fontWeight: FontWeight.w300,
                              color: Colors.grey
                          )
                      ),
                    ),
                  ],
                ),
              ),

              //old password field
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child:  Form(
                        child: Column(
                          children: <Widget>[
                            FadeInAnimation(
                                delay: 1.9,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(18),
                                    hintText: "Enter your old password",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.shade800),
                                        borderRadius: BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(color: Colors.green.shade700),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                            ),
                            const SizedBox(height: 20,),
                            //new password field
                            FadeInAnimation(
                              delay: 2.1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18),
                                  hintText: "New password",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade800),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.green.shade700),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            //confirm password field
                            FadeInAnimation(
                              delay: 2.4,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(18),
                                  hintText: "Confirm password",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade800),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  BorderSide(color: Colors.green.shade700),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20,),
                            // Reset password button

                            ElevatedButton(
                              //pressed on to change password animation screen
                              onPressed: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangeAnimationPage ()));
                              },
                              style: ButtonStyle(
                                  side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade800)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                  fixedSize: const MaterialStatePropertyAll(Size.fromWidth(370)),
                                  padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 20),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(Colors.green[700])),
                              child: Text(
                                'Reset Password',
                                style: TextStyle(fontSize: 18.0,color: Colors.grey[100]),
                              ),
                            ),

                          ],
                        ),

                    ),
                  ),
                  FadeInAnimation(
                    delay: 2.4,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50,bottom: 20),
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
              )

            ],
          ),
        ),
      ),
    );
  }
}
