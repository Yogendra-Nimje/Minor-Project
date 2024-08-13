
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

  //usernamè controller
  final TextEditingController _usernameController = TextEditingController();
  bool _notEmpty = false;

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

    //username field
    _usernameController.addListener(_updateNotEmpty);

  }

  @override
  void dispose() {
    _controller.dispose();

    //remove username controller

    _usernameController.removeListener(_updateNotEmpty);
    _usernameController.dispose();
    super.dispose();
  }

  void _updateNotEmpty() {
    setState(() {
      _notEmpty = _usernameController.text.isNotEmpty;
    });
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
                                  textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                                ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
        
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'User_name',
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: _notEmpty
                              ? const Icon(Icons.check, color: Colors.blue)
                              : const Icon(Icons.check, color: Colors.grey),
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
                          suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[300],
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          )
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
