
import 'package:find_in/Services/globle_methods.dart';
import 'package:find_in/componants/fade_animetion.dart';
import 'package:find_in/pages/login_pages/forgot_password.dart';
import 'package:find_in/pages/login_pages/sign_up_page.dart';
import 'package:find_in/user_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provide.dart';

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
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  final FocusNode _passFocusNode = FocusNode();

  final _loginKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _notEmpty = false;
  bool onClick = false;
  bool _isloading = false;

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
    _useremailController.addListener(_updateNotEmpty);

  }

  @override
  void dispose() {
    _controller.dispose();

    //remove username controller

    _useremailController.removeListener(_updateNotEmpty);
    _useremailController.dispose();
    super.dispose();
  }

  void _updateNotEmpty() {
    setState(() {
      // if(_usernameController.text.length<6)
      //   {
      //     _notEmpty=!_notEmpty;
      //   }

      _notEmpty = _useremailController.text.isNotEmpty;
    });
  }

  void _submitFormLogin() async {
    final isValid = _loginKey.currentState!.validate();
    if(isValid){
      setState(() {
        _isloading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          email: _useremailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        Navigator.push(context, MaterialPageRoute(builder: (_) => UserState()));
      } catch (error) {
        setState(() {
          _isloading = false;
        });
        GlobleMethods.ShowErrorDialog(error: error.toString(), ctx: context);
        print("error $error");
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Upper Image/Icon
                       Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: IconButton(
                            color: Colors.grey.shade800,
                            onPressed: () {
                              setState(() {
                                onClick = !onClick;
                                Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                              });
                            },
                            icon:
                              onClick
                                  ? const Icon(Icons.sunny,color: Colors.white,)
                                  : const Icon(Icons.dark_mode),
                            ),
                          ),
                        ),

                            // 'find.in' app logo
                             Center(
                                  child: Text("Find.in",style: GoogleFonts.baskervville(textStyle: const TextStyle(fontSize: 40,color: Colors.green))),
                                ),

                       const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                       FadeInAnimation(
                         delay: 1,
                         child: Align(
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
                       ),
                      const SizedBox(height: 20.0),
                      // Old user and Create New Text
                       FadeInAnimation(
                         delay: 1.5,
                         child: Row(
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
                                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                              },
                              child: Text("Create New",
                                  style: GoogleFonts.gentiumBookPlus(
                                    textStyle: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                                  ),
                              ),
                            ),
                          ],
                                             ),
                       ),
                      const SizedBox(height: 20.0),

                      FadeInAnimation(
                        delay: 2,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: _useremailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'User Email',
                            hintStyle:  TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                            filled: true,
                            // fillColor:Theme.of(context).colorScheme.primary,
                            suffixIcon: _notEmpty
                                ? const Icon(Icons.email, color: Colors.blue)
                                : const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      FadeInAnimation(
                        delay: 2.5,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          focusNode: _passFocusNode,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: !_obscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            } else if (value.length < 7) {
                              return "Password must be at least 7 characters long";
                            } /*else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{7,}$').hasMatch(value)) {
                              return "Password must contain at least one letter and one number";
                            }*/
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            hintText: 'Password',
                            hintStyle:  TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                            filled: true,
                            // fillColor: Theme.of(context).colorScheme.primary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Forget Password and Reset
                      FadeInAnimation(
                        delay: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordPage()));
                              },
                              child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                            const Text(
                              '/ ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            GestureDetector(
                              onTap: (){

                                //reset tha username and password field
                                setState(() {
                                  _useremailController.clear();
                                  _passwordController.clear();
                                });
                              },
                              child: const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                                ),
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 20,),

                      // Login Now Button
                      FadeInAnimation(
                        delay: 3.5,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(

                            //pressed on to home Page
                            onPressed: _submitFormLogin,/*() {
                              _submitFormLogin();
                              //Navigator.pushNamed(context, '/homepage');
                            },*/
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              backgroundColor: Colors.green[500],
                              shadowColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Login Now',
                              style: TextStyle(fontSize: 18.0,color: Colors.grey[100]),
                            ),
                          ),
                        ),
                      ),
                      /*const SizedBox(height: 20.0),
                      const Center(
                        child: Text(
                          "Or"
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    FadeInAnimation(
                      delay: 4,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric( vertical: 15),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/google.png', // Add a Google logo in your assets
                              height: 24.0,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(fontSize: 16.0,color: Theme.of(context).colorScheme.inversePrimary),
                            ),
                          ],
                        ),
                      ),
                    ),*/
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
