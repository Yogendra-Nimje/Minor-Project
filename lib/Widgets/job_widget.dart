import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_in/Services/globle_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Jobs/job_detail_screen.dart';

class JobWidget extends StatefulWidget {

  final String jobTitle;
  final String jobDescription;
  final String jobId;
  final String uploadedBy;
  final String userImage;
  final String name;
  final bool recruitment;
  final String email;
  final String location;

  const JobWidget({
    required this.jobTitle,
    required this.jobDescription,
    required this.jobId,
    required this.uploadedBy,
    required this.userImage,
    required this.name,
    required this.recruitment,
    required this.email,
    required this.location,
  });

  @override
  State<JobWidget> createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _deleteDialog(){
    User? user = _auth.currentUser;
    final _uid = user!.uid;
    showDialog(
        context: context,
        builder: (ctx){
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () async {
                    try{
                      if(widget.uploadedBy == _uid){
                        await FirebaseFirestore.instance.collection("jobs")
                            .doc(widget.jobId)
                            .delete();
                        await Fluttertoast.showToast(
                          msg: "Job has been deleted",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.grey[500],
                          fontSize: 18,
                        );
                        Navigator.canPop(context) ? Navigator.pop(context) : null;
                      }
                      else{
                        GlobleMethods.ShowErrorDialog(error: "You cannot perform this action", ctx: ctx);
                      }
                    }catch(error){
                      GlobleMethods.ShowErrorDialog(error: "This task cannot be deleted", ctx: ctx);
                    }finally{}
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => JobDetailScreen(
            uploadedBy: widget.uploadedBy,
            jobId: widget.jobId,
          )));},
        onLongPress: (){
          _deleteDialog();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: CircleAvatar(radius: 30,backgroundImage: NetworkImage(widget.userImage),),
        ),
        title: Text(
          widget.jobTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.jobDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.green[500],
        ),
      ),
    );
  }
}
