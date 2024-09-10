import 'package:find_in/pages/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provide.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                            MaterialPageRoute(builder: (context)=>const EditProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.inversePrimary,
                        onPrimary: Colors.white,
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
                          onTap: () {},
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