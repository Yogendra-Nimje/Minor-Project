import 'package:animated_background/animated_background.dart';
import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _colorAnimation.value!,
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Upper Image/Icon
                       Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Icon(
                            Icons.sunny,
                            size: 40.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
        
                      const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                      // "Hey, Login Now!" text
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hey,\nLogin Now!',
                          style: GoogleFonts.baskervville(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 40,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Old user and Create New Text
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'I Am A Old User / ',
                            style: GoogleFonts.gentiumBookPlus(
                              textStyle: const TextStyle(
                                fontSize: 16.0
                              )
                            )
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text("Create New",
                                style: GoogleFonts.arefRuqaaInk(
                                  textStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                                ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
        
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'User_name',
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: const Icon(Icons.check),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          )
                                // suffixIcon: IconButton(
                                //   icon: Icon(
                                //     _obscureText
                                //         ? Icons.visibility_off
                                //         : Icons.visibility,
                                //   ),
                                //   onPressed: () {
                                //     setState(() {
                                //       _obscureText = !_obscureText;
                                //     });
                                //   },
                                // ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
        
                      // Forget Password and Reset
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              //go to forget page
                            },
                            child: const Text(
                                'Forget Password?',
                                style: TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                          ),
                          const Text(
                            '/',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          GestureDetector(
                            onTap: (){
                              //reset tha username and password field
                            },
                            child: const Text(
                                'Reset',
                                style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 20,),
                      // Login Now Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: Colors.yellow[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Login Now',
                            style: TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // Skip Now Text
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
        
            );
          },
        ),
      ),
    );
  }
}
