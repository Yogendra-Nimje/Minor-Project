import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                // "Hey, Sign Up Now!" text
                 Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey,\nSign Up Now!',
                    style: GoogleFonts.baskervville(
                      textStyle: const TextStyle(
                        fontSize: 28.0,
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
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.perm_identity_rounded),
                          hintText: 'First Name',
                          filled: true,
                          fillColor: Colors.grey[200],
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
                      child: TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.perm_identity_rounded),
                          hintText: 'Last Name',
                          filled: true,
                          fillColor: Colors.grey[200],
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
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(CupertinoIcons.person_alt_circle),
                    hintText: 'Username',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
        
                // Email Field
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
        
                // Password Field
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline_rounded),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
        
                // Confirm Password Field
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline_rounded),
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.grey[200],
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
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      backgroundColor: Colors.yellow[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Sign Up Now',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
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
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
