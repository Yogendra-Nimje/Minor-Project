import 'package:find_in/pages/home_pages/applied_screen.dart';
import 'package:find_in/pages/home_pages/profile_page.dart';
import 'package:find_in/pages/home_pages/upload_job_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AppliedScreen(),
    const UploadJobScreen(),
    const ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.archivebox),
            activeIcon: Icon(CupertinoIcons.archivebox_fill),
            label: 'Applied',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file_outlined),
            activeIcon: Icon(Icons.upload_file_rounded),
            label: 'JobUpload',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green.shade500,
        unselectedItemColor: Colors.grey.shade400,
      ),
    );
  }
}

