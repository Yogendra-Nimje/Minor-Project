import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_in/Persistent/persistent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Widgets/job_widget.dart';
import "package:intl/intl.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _jobSearchController = TextEditingController();
  String searchQuery = "Search query";

  // Method to get the current date formatted
  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMMM yyyy').format(now);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Persistent persistent = Persistent();
    persistent.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getCurrentDate(), // Display today's date
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "Search, Find, and Apply",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(CupertinoIcons.bell),
            color: Colors.black, // Icon color
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Expanded ListView for job listings
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                .collection("jobs")
                .where("recruitment", isEqualTo: true)
                .orderBy("createdAt", descending: false)
                .snapshots(),
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if (snapshot.connectionState == ConnectionState.active){
                    if(snapshot.data?.docs.isNotEmpty){
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index){
                          return JobWidget(
                            jobTitle: snapshot.data?.docs[index]["jobTitle"],
                            jobDescription: snapshot.data?.docs[index]["jobDescription"],
                            jobId: snapshot.data?.docs[index]["jobId"],
                            uploadedBy: snapshot.data?.docs[index]["uploadedBy"],
                            userImage: snapshot.data?.docs[index]["userImage"],
                            name: snapshot.data?.docs[index]["name"],
                            recruitment: snapshot.data?.docs[index]["recruitment"],
                            email: snapshot.data?.docs[index]["email"],
                            location: snapshot.data?.docs[index]["location"],
                          );
                        },
                      );
                    }
                    else{
                      return const Center(
                        child: Text("There is no jobs"),
                      );
                    }
                  }
                  return const Center(
                    child: Text(
                      "Something want wrong",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

