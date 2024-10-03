import 'package:find_in/pages/edit_profile.dart';
import 'package:find_in/pages/editprofile.dart';
import 'package:find_in/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provide.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey[500],
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 36,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Sign out",
                  style: TextStyle(color: Colors.white, fontSize: 28,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            "Do you want to Log Out?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
                child: Text("NO", style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
            TextButton(onPressed: (){
              _auth.signOut();
              Navigator.canPop(context) ? Navigator.pop(context) : null;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserState()));
            },
                child: Text("YES", style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('lib/assets/img.jpg'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'User Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'User.Name@icloud.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> EProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Text('Edit Profile',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    'Inventories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[400]
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('My stores'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.support_agent),
                          title: const Text('Support'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Urbanist-Bold",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[400]
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Push notifications'),
                          value: true,
                          onChanged: (value) {},
                          secondary: const Icon(Icons.notifications_none_outlined),
                        ),
                        SwitchListTile(
                          title: const Text('Face ID'),
                          value: true,
                          onChanged: (value) {},
                        ),
                        SwitchListTile(
                          title: const Text("Dark Mode"),
                          value: Provider.of<ThemeProvider>(context).isDarkMode,
                          onChanged:(value) {
                            Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                          },
                          secondary: const Icon(Icons.dark_mode),
                        ),
                        ListTile(
                          leading: const Icon(Icons.password),
                          title: const Text('PIN Code'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('Setting'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout',style: TextStyle(color: Colors.red),),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            _logout(context);
                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}