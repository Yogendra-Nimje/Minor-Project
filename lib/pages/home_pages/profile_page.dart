import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_in/Services/globle_methods.dart';
import 'package:find_in/Services/globle_variable.dart';
import 'package:find_in/pages/edit_profile.dart';
import 'package:find_in/pages/editprofile.dart';
import 'package:find_in/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../theme/theme_provide.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? name;
  String email = "";
  String phoneNumber = "";
  String imageUrl = "";
  String joinedAt = "";
  bool _isLoading = false;
  bool _isSameUser = false;

  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(widget.userId)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          name = userDoc.get("userName");
          email = userDoc.get("email");
          phoneNumber = userDoc.get("mobileNumber");
          imageUrl = userDoc.get("userImage");
          Timestamp joinedAtTimeStamp = userDoc.get("createAt");
          var joinedDate = joinedAtTimeStamp.toDate();
          joinedAt =
              "${joinedDate.year} - ${joinedDate.month} - ${joinedDate.day}";
        });
        User? user = _auth.currentUser;
        final _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userId;
        });
      }
    } catch (error) {
    } finally {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Widget userInfo({required IconData icon, required String content}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[500],
            title: const Row(
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
            content: const Text(
              "Do you want to Log Out?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text("NO",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const UserState()));
                },
                child: const Text("YES",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
            ],
          );
        });
  }

  Widget _contactBy({
    required Color color,
    required Function fct,
    required IconData icon,
  }) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: () {
            fct();
          },
        ),
      ),
    );
  }

  void _openWhatsAppChats() async {
    var url = "http://wa.me/$phoneNumber?text=HelloWorld";
    launchUrlString(url);
  }

  void _mailTo() async {
    final Uri params = Uri(
      scheme: "mailTo",
      path: email,
      query:
          "subject=Write subject here, Please&body=Hello, please write details here",
    );
    final url = params.toString();
    launchUrlString(url);
  }

  void _callPhoneNumber() async {
    var url = "tel://$phoneNumber";
    launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[500],
      ),
      body: Center(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    clipBehavior: Clip.none, // Allow overflow for the image
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                              height: 80), // Adjusted height to push name lower
                          Card(
                            color: Colors.grey[360],
                            margin: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height: 60), // Adjust spacing for name
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      name == null ? "Name here" : name!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 30),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Account Information :",
                                      style: TextStyle(
                                        color: Colors.black26,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: userInfo(
                                        icon: Icons.email, content: email),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: userInfo(
                                        icon: Icons.phone,
                                        content: phoneNumber),
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 35),
                                  _isSameUser
                                  ?
                                  Container()
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _contactBy(
                                          color: Colors.green,
                                          fct: (){
                                            _openWhatsAppChats();
                                          },
                                          icon: FontAwesome.whatsapp,
                                      ),
                                      _contactBy(
                                          color: Colors.red,
                                          fct: (){
                                            _mailTo();
                                          },
                                          icon: Icons.mail_lock_outlined,
                                      ),
                                      _contactBy(
                                          color: Colors.purple,
                                          fct: (){
                                            _callPhoneNumber();
                                          },
                                          icon: Icons.call,
                                      ),
                                    ],
                                  ),
                                  !_isSameUser
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: ElevatedButton(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.grey[350]),
                                                child: Column(
                                                  children: [
                                                    SwitchListTile(
                                                      title: const Text(
                                                          'Push notifications'),
                                                      value: true,
                                                      onChanged: (value) {},
                                                      secondary: const Icon(Icons
                                                          .notifications_none_outlined),
                                                    ),
                                                    SwitchListTile(
                                                      title:
                                                          const Text('Face ID'),
                                                      value: true,
                                                      onChanged: (value) {},
                                                      secondary: const Icon(
                                                          Icons.person),
                                                    ),
                                                    SwitchListTile(
                                                      title: const Text(
                                                          "Dark Mode"),
                                                      value: Provider.of<
                                                                  ThemeProvider>(
                                                              context)
                                                          .isDarkMode,
                                                      onChanged: (value) {
                                                        Provider.of<ThemeProvider>(
                                                                context,
                                                                listen: false)
                                                            .toggleTheme();
                                                      },
                                                      secondary: const Icon(
                                                          Icons.dark_mode),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.password),
                                                      title: const Text(
                                                          'PIN Code'),
                                                      trailing: const Icon(Icons
                                                          .arrow_forward_ios),
                                                      onTap: () {},
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.settings),
                                                      title:
                                                          const Text('Setting'),
                                                      trailing: const Icon(Icons
                                                          .arrow_forward_ios),
                                                      onTap: () {},
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.logout),
                                                      title: const Text(
                                                        'Logout',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      trailing: const Icon(Icons
                                                          .arrow_forward_ios),
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
                          ),
                        ],
                      ),
                      // Image Positioned Correctly with Spacing
                      Positioned(
                        top: -10, // Adjust this value to control image height
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: size.width * 0.26,
                            height: size.height * 0.26,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 8,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl == null
                                      ? "https://www.shutterstock.com/image-vector/young-smiling-woman-sitting-cross-260nw-2284152983.jpg"
                                      : imageUrl,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
