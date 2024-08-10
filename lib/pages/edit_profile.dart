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
                Text("Save ",style: TextStyle(fontWeight:FontWeight.bold),),
                Icon(Icons.save_alt,color: Colors.blue,)
              ],
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name"),
                  TextField(

                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: nameController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: false,
                  icon: Text("Username"),
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
