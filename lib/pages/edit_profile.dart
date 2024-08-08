import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pronounsController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController linksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with actual image asset
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 15, color: Colors.white),
                        onPressed: () {
                          // Change profile photo action
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pronounsController,
              decoration: const InputDecoration(
                labelText: 'Pronouns',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: linksController,
              decoration: const InputDecoration(
                labelText: 'Links',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Switch to professional account action
              },
              child: const Text('Switch to professional account'),
            ),
            ElevatedButton(
              onPressed: () {
                // Create avatar action
              },
              child: const Text('Create avatar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Personal information settings action
              },
              child: const Text('Personal information settings'),
            ),
          ],
        ),
      ),
    );
  }
}
