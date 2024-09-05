import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';

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

  XFile? profilAvatarCurrentImage;
  bool allowEdit=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: const [
          Row(
              children: [
                Icon(Icons.remove_red_eye_outlined),
                Icon(CupertinoIcons.lightbulb),
              ],
            ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  ProfileAvatar(
                    image: profilAvatarCurrentImage,
                    radius: 60,
                    allowEdit: allowEdit,
                    addImageIcon: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                    removeImageIcon: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Icon(Icons.close),
                      ) ,
                    ),
                    onImageChanged: (XFile? image){
                      setState(() {
                        profilAvatarCurrentImage= image;
                      });
                    },
                    onImageRemoved: (){
                      setState(() {
                        profilAvatarCurrentImage=null;
                      });
                    },
                    getImageSource: (){
                      return showDialog<ImageSource>(
                        context: context,
                        builder: (context){
                          return SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                child: const Text("Camera"),
                                onPressed: (){
                                  Navigator.of(context).pop(ImageSource.camera);
                                },
                              ),
                              SimpleDialogOption(
                                  child: const Text("Gallery"),
                                  onPressed: (){
                                    Navigator.of(context).pop(ImageSource.gallery);
                                  }),
                            ],
                          );
                        },
                      ).then((value){
                        return value?? ImageSource.gallery;
                      });
                    },
                    getPreferredCameraDevice: () {
                      return showDialog<CameraDevice>(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                child: const Text("Rear"),
                                onPressed: () {
                                  Navigator.of(context).pop(CameraDevice.rear);
                                },
                              ),
                              SimpleDialogOption(
                                  child: const Text("Front"),
                                  onPressed: () {
                                    Navigator.of(context).pop(CameraDevice.front);
                                  }),
                            ],
                          );
                        },
                      ).then(
                            (value) {
                          return value ?? CameraDevice.rear;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              width: 80,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'First Name ',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(hinttext: "username", labeltext: "Username", controller: usernameController),
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

class CustomTextField extends StatefulWidget {

  final String labeltext;
  final String hinttext;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hinttext,
    required this.labeltext,
    required this.controller
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.labeltext,
                style: const TextStyle(fontSize: 16),
              ),
              const TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: widget.hinttext,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
              )
          ),
        )
      ],

    );
  }
}