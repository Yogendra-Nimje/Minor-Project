import 'dart:io';

import 'package:find_in/Services/globle_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userFirstnameController = TextEditingController();
  final TextEditingController _userLastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();

  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _isloading = false;

  get label => null;

  void _submitFormOnSignUp() async {
    final isValid = _signUpKey.currentState!.validate();
    if(isValid){
      setState(() {
        _isloading = true;
      });
      try{
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );

        final User? user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child("userImages").child(_uid + ".jpg");

        FirebaseFirestore.instance.collection("user").doc(_uid).set({
          "id": _uid,
          "firstName": _userFirstnameController.text,
          "lastName": _userLastnameController.text,
          "userName": _usernameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "mobileNumber": _mobileNumberController.text,
          "address": _addressController.text,
          "createAt": Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }catch(error){
        setState(() {
          _isloading = false;
        });
        GlobleMethods.ShowErrorDialog(error: error.toString(), ctx: context);
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _signUpKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child:  Center(
                        child: Text("Find.in",style: GoogleFonts.baskervville(textStyle: const TextStyle(fontSize: 60,color: Colors.green))),
                      ),
                    ),
                  // ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.sunny), label: null),
                  // "Hey, Sign Up Now!" text
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hey,\nSign Up Now!',
                      style: GoogleFonts.baskervville(
                        textStyle: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Row for First Name and Last Name Fields
                  Row(
                    children: [
                      // First Name Field
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller: _userFirstnameController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Feild can not be empty!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            icon: const Icon(Icons.perm_identity_rounded),
                            hintText: 'First Name',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0), // Space between First Name and Last Name

                      // Last Name Field
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          controller: _userLastnameController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Feild can not be empty!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            filled: true,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 15.0),

                  // Username Field
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_emailFocusNode),
                    controller: _usernameController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Feild can not be empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      icon: const Icon(CupertinoIcons.person_alt_circle),
                      hintText: 'Username',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Email Field
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_passFocusNode),
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
                      icon: const Icon(Icons.email_outlined),
                      hintText: 'Email',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Password Field
                  TextFormField(
                    textInputAction: TextInputAction.next,
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
                      icon: const Icon(Icons.lock_outline_rounded),
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
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Confirm Password Field
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    obscureText: !_obscureText1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password"; // Error if empty
                      } else if (value != _passwordController.text) { // Check if passwords match
                        return "Passwords do not match"; // Error if not matching
                      }
                      return null; // No error
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Confirm Password Field
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _mobileNumberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your mobile number"; // Error if empty
                      } else if (value.length != 10) { // Check if passwords match
                        return "your mobile number must contain 10 digit"; // Error if not matching
                      }
                      return null; // No error
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.mobile_friendly_outlined),
                      hintText: 'Mobile Number',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Confirm Password Field
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.streetAddress,
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your address"; // Error if empty
                      }
                      return null; // No error
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.location_on_outlined),
                      hintText: 'Address',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: _isloading ?
                        Center(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : ElevatedButton(
                      onPressed: () {
                        _submitFormOnSignUp();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Sign Up Now',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Already have an account? Log In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 16.0,color: Colors.grey[500]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
