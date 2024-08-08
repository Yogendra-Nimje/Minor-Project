import 'package:find_in/pages/edit_profile.dart';
import 'package:find_in/pages/settting_page.dart';
import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? profileimage;
  bool allowEdit=false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        elevation: 0,
        actions: [
          PopupMenuButton(
            surfaceTintColor: Colors.white,
            onSelected: (String result) {
              switch (result) {
                case 'Edit Profile':
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                  break;
                case 'Setting':
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsPage()));
                  break;
                case 'About':
                // Handle Option 3
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Edit Profile',
                  child: Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const PopupMenuItem<String>(
                  value: 'Setting',
                  child: Text('Setting',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                const PopupMenuItem<String>(
                  value: 'About',
                  child: Text('About',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img.png'), // Add your profile image here
            ),
            const SizedBox(height: 16),
            const Text(
              'Yogendra Nimje',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Sr. Flutter Developer',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Complete Your Profile (1/4)'),
            //   ],
            // ),
            const SizedBox(height: 8),
            // LinearProgressIndicator(
            //   value: 0.25,
            //   backgroundColor: Colors.grey[300],
            //   color: Colors.orange,
            // ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileOption(
                  icon: Icons.person,
                  text: 'Set Your Profile Details',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.upload_file,
                  text: 'Upload Your Resume',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.edit,
                  text: 'Write Your Bio',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildListTile(
              icon: Icons.settings,
              text: 'Setting',
              onTap: () {
                MaterialPageRoute(builder: (context)=>const SettingsPage());
              },
            ),
            _buildListTile(
              icon: Icons.help,
              text: 'Help & Feedback',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
