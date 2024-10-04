import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/globle_methods.dart';

class EProfilePage extends StatefulWidget {
  @override
  _EProfilePageState createState() => _EProfilePageState();
}

class _EProfilePageState extends State<EProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userFirstnameController = TextEditingController();
  final TextEditingController _userLastnameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _userImageFile;
  String? imageUrl;

  bool _isLoading = false;

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.camera, color: Colors.green[700]),
                    ),
                    Text("Camera", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.image, color: Colors.green[700]),
                    ),
                    Text("Gallery", style: TextStyle(color: Colors.green[700], fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
    Navigator.pop(context);
  }

  void _cropImage(String filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );

    if (croppedImage != null) {
      setState(() {
        _userImageFile = File(croppedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final userDoc = await _firestore.collection("user").doc(_auth.currentUser?.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userFirstnameController.text = userDoc.get("firstName");
          _userLastnameController.text = userDoc.get("lastName");
          _usernameController.text = userDoc.get("userName");
          _emailController.text = userDoc.get("email");
          _mobileNumberController.text = userDoc.get("mobileNumber");
          _addressController.text = userDoc.get("address");
          imageUrl = userDoc.get("userImage");
          // Load existing user image if available
          if (imageUrl != null) {
            _userImageFile = File(imageUrl!); // Optionally load image if it was previously stored
          }
        });
      }
    } catch (error) {
      GlobleMethods.ShowErrorDialog(error: error.toString(), ctx: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateUserProfile() async {
    final isValid = _updateKey.currentState!.validate();
    if (isValid) {
      if (_userImageFile == null) {
        GlobleMethods.ShowErrorDialog(error: "Please pick an Image", ctx: context);
        return;
      }

      setState(() {
        _isLoading = true;
      });
      try {
        final user = _auth.currentUser;
        final _uid = user!.uid;
        final ref = FirebaseStorage.instance.ref().child("userImages").child("$_uid.jpg");
        await ref.putFile(_userImageFile!);
        imageUrl = await ref.getDownloadURL();

        // Update user data in Firestore
        await _firestore.collection("user").doc(_uid).set({
          "id": _uid,
          "firstName": _userFirstnameController.text,
          "lastName": _userLastnameController.text,
          "userName": _usernameController.text,
          "email": _emailController.text,
          "userImage": imageUrl,
          "mobileNumber": _mobileNumberController.text,
          "address": _addressController.text,
          "createAt": Timestamp.now(),
        });

        // Navigate back or show success message
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        GlobleMethods.ShowErrorDialog(error: error.toString(), ctx: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _updateKey,
            child: Column(
              children: [
                InkWell(
                  onTap: _showImageDialog,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _userImageFile != null ? NetworkImage(imageUrl!) : null,
                    child: _userImageFile == null
                        ? const Icon(Icons.add_a_photo, size: 50) // Placeholder icon when no image is selected
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('First Name', _userFirstnameController),
                const SizedBox(height: 12),
                _buildTextField('Last Name', _userLastnameController),
                const SizedBox(height: 12),
                _buildDisabledTextField('Username', _usernameController),
                const SizedBox(height: 12),
                _buildDisabledTextField('Email', _emailController),
                const SizedBox(height: 12),
                _buildTextField('Mobile', _mobileNumberController),
                const SizedBox(height: 16),
                _buildAddressFields('Location', _addressController),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _updateUserProfile,
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDisabledTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      enabled: true,
    );
  }

  Widget _buildAddressFields(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      enabled: true,
    );
  }
}
