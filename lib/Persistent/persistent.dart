import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Services/globle_variable.dart';

class Persistent {
  static List<String> jobCategoryList = [
    "Architecture and Construction",
    "Education and Training",
    "Development - Programming",
    "Business",
    "Information Technology",
    "Human Resources",
    "Marketing",
    "Design",
    "Accounting",
  ];

  void getData()async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    name = userDoc.get("userName");
    userImage = userDoc.get("userImage");
    location = userDoc.get("address");
  }
}
