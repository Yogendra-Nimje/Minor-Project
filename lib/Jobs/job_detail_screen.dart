import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_in/Services/globle_methods.dart';
import 'package:find_in/Services/globle_variable.dart';
import 'package:find_in/Widgets/comments_widget.dart';
import 'package:find_in/pages/home_pages/home_page.dart';
import 'package:find_in/pages/home_pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

class JobDetailScreen extends StatefulWidget {
  final String uploadedBy;
  final String jobId;

  const JobDetailScreen({
    super.key,
    required this.uploadedBy,
    required this.jobId,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _commentController = TextEditingController();

  bool _isCommenting = false;

  String? authorName;
  String? userImageUrl;
  String? jobCategory;
  String? jobDescription;
  String? jobTitle;
  bool? recruitment;
  Timestamp? postedDateTimeStamp;
  Timestamp? deadLineDateTimeStamp;
  String? postedDate;
  String? deadLineDate;
  String? locationCompany = "";
  String? emailCompany = "";
  int? applicants = 0;
  bool isDeadLineAvailable = false;
  bool showComments = false;


  Future<void> getJobData() async{
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.uploadedBy)
        .get();
    
    if(userDoc == null){
      return;
    }
    else{
      setState(() {
        authorName = userDoc.get("userName");
        userImageUrl = userDoc.get("userImage");
      });
    }
    final DocumentSnapshot jobDatabase = await FirebaseFirestore.instance
    .collection("jobs")
    .doc(widget.jobId)
    .get();

    if(jobDatabase == null){
      return;
    }else{
      setState(() {
        jobTitle = jobDatabase.get("jobTitle");
        jobDescription = jobDatabase.get("jobDescription");
        recruitment = jobDatabase.get("recruitment");
        emailCompany = jobDatabase.get("email");
        locationCompany = jobDatabase.get("location");
        applicants = jobDatabase.get("applicants");
        postedDateTimeStamp = jobDatabase.get("createdAt");
        deadLineDateTimeStamp = jobDatabase.get("deadLineDateTimeStamp");
        deadLineDate = jobDatabase.get("deadLineDate");


        var postDate = postedDateTimeStamp!.toDate();
        postDate = "${postDate.year} - ${postDate.month} - ${postDate.day}" as DateTime;
      });

      var date = deadLineDateTimeStamp!.toDate();
      isDeadLineAvailable = date.isAfter(DateTime.now());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobData();
  }

  Widget dividerWidget(){
    return const Column(
      children: [
        SizedBox(height: 10),
        Divider(
          thickness: 1,
          color: Colors.green,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  applyForJob(){
    final Uri params = Uri(
      scheme: "mailto",
      path: emailCompany,
      query: "subject=Applying fo $jobTitle&body=Hello, please attach Resume CV file",
    );
    final url = params.toString();
    launchUrlString(url);
    addNewApplicant();
  }

  void addNewApplicant() async {
    var docRef = FirebaseFirestore.instance
        .collection("jobs")
        .doc(widget.jobId);

    docRef.update({
      "applicants": applicants! + 1,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.green[500],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.close, size: 30, color: Colors.grey[800],),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
            ),
          ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("jobs")
              .doc(widget.jobId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No data found"));
            }

            // Data exists
            var jobData = snapshot.data!.data() as Map<String, dynamic>;

            var date = deadLineDateTimeStamp!.toDate();
            isDeadLineAvailable = date.isAfter(DateTime.now());

            DateTime postDate = postedDateTimeStamp?.toDate() ?? DateTime.now();
            // Format the date as "YYYY - MM - DD"
            String formattedDate = "${postDate.year} - ${postDate.month.toString().padLeft(2, '0')} - ${postDate.day.toString().padLeft(2, '0')}";
            DateTime lastDate = deadLineDateTimeStamp?.toDate() ?? DateTime.now();
            // Format the date as "YYYY - MM - DD"
            String lastFormattedDate = "${lastDate.year} - ${lastDate.month.toString().padLeft(2, '0')} - ${lastDate.day.toString().padLeft(2, '0')}";

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Job Title
                              Text(
                                jobData["jobTitle"] ?? "No Title",
                                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 16),

                              // Profile Image and Author Name Section
                              Row(
                                children: [
                                  // Profile Image
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.grey,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          jobData["userImage"] ??
                                              "https://example.com/default-profile-image.png", // Placeholder image if userImageUrl is null
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // Author Name and Company Location
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobData["name"] ?? "Author not available",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        jobData["location"] ?? "Not Available",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                             dividerWidget(),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   applicants.toString(),
                                   style: const TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 18,
                                     color: Colors.white,
                                   ),
                                 ),
                                 const SizedBox(width: 6),
                                 const Text(
                                   "Applicants",
                                   style: TextStyle(color: Colors.grey),
                                 ),
                                 const SizedBox(width: 10),
                                 const Icon(
                                   Icons.how_to_reg_outlined,
                                   color: Colors.green,
                                 ),
                               ],
                             ),

                             FirebaseAuth.instance.currentUser!.uid != widget.uploadedBy
                              ?
                              Container()
                              :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerWidget(),
                                  const Text(
                                    "Recruitment",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: (){
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;

                                          if(_uid == widget.uploadedBy){
                                            try{
                                              FirebaseFirestore.instance
                                                  .collection("jobs")
                                                  .doc(widget.jobId)
                                                  .update({"recruitment": true});
                                            }catch(error){
                                              GlobleMethods.ShowErrorDialog(error: "Action cannot be performed", ctx: context);
                                            }
                                          }
                                          else{
                                            GlobleMethods.ShowErrorDialog(error: "You cannot perform this action", ctx: context);
                                          }
                                          getJobData();
                                        },
                                        child: const Text(
                                          "ON",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: recruitment == true ? 1 : 0,
                                        child: const Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 40),

                                      TextButton(
                                        onPressed: (){
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;

                                          if(_uid == widget.uploadedBy){
                                            try{
                                              FirebaseFirestore.instance
                                                  .collection("jobs")
                                                  .doc(widget.jobId)
                                                  .update({"recruitment": false});
                                            }catch(error){
                                              GlobleMethods.ShowErrorDialog(error: "Action cannot be performed", ctx: context);
                                            }
                                          }
                                          else{
                                            GlobleMethods.ShowErrorDialog(error: "You cannot perform this action", ctx: context);
                                          }
                                          getJobData();
                                        },
                                        child: const Text(
                                          "OFF",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: recruitment == false ? 1 : 0,
                                        child: const Icon(
                                          Icons.check_box,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              dividerWidget(),
                              const Text(
                                "jobDescription",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                jobDescription == null ? "" : jobDescription!,
                                //jobData["jobDescription"] ?? "Not Available",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              dividerWidget(),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            isDeadLineAvailable ? "Actively Recruiting, Send CV/Resume:"
                                                : "Deadline Passed away.",
                                            style: TextStyle(
                                              color: isDeadLineAvailable ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              applyForJob();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 5,
                                              backgroundColor: Colors.green[500],
                                              shadowColor: Colors.grey[400],
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 14),
                                              child: Text(
                                                "Easy Apply Now",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        dividerWidget(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Uploaded on:",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Deadline date:",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              deadLineDate == null ? "" : deadLineDate!,
                                              //lastFormattedDate,
                                              style: const TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        dividerWidget(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AnimatedSwitcher(
                                        duration: Duration(microseconds: 500),
                                        child: _isCommenting
                                        ?
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: TextField(
                                                controller: _commentController,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                maxLength: 200,
                                                keyboardType: TextInputType.text,
                                                maxLines: 6,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                                                  enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                                  child: ElevatedButton(
                                                    onPressed: ()async{
                                                      if(_commentController.text.length < 7){
                                                        GlobleMethods.ShowErrorDialog(error: "Comment cannot be less than 7 characters", ctx: context);
                                                      }
                                                      else{
                                                        final _generateId = Uuid().v4();
                                                        await FirebaseFirestore.instance
                                                        .collection("jobs")
                                                        .doc(widget.jobId)
                                                        .update({
                                                          "jobComments":
                                                              FieldValue.arrayUnion([{
                                                                "userId": FirebaseAuth.instance.currentUser!.uid,
                                                                "commentId": _generateId,
                                                                "name": name,
                                                                "userImageUrl": userImage,
                                                                "commentBody": _commentController.text,
                                                                "time": Timestamp.now(),
                                                              }]),
                                                        });
                                                        await Fluttertoast.showToast(
                                                          msg: "Your comment has been added",
                                                          toastLength: Toast.LENGTH_LONG,
                                                          backgroundColor: Colors.grey[500],
                                                          fontSize: 18,
                                                        );
                                                        _commentController.clear();
                                                      }
                                                      setState(() {
                                                        showComments = true;
                                                      });
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 5,
                                                      backgroundColor: Colors.green[500],
                                                      shadowColor: Colors.grey[400],
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.send,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  ),
                                                  TextButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          _isCommenting = !_isCommenting;
                                                          showComments = false;
                                                        });
                                                      },
                                                      child: Text("Cancel", style: TextStyle(color: Colors.black),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                        :
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  _isCommenting = !_isCommenting;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.add_comment,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  showComments = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      showComments == false
                                      ?
                                      Container()
                                      :
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                          .collection("jobs")
                                          .doc(widget.jobId)
                                          .get(),
                                          builder: (context, snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting){
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            else{
                                              if(snapshot.data == null){
                                                Center(
                                                  child: Text("No Comment for this job."),
                                                );
                                              }
                                            }
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return CommentWidget(
                                                  commentId:  snapshot.data!["jobComments"][index]["commentId"],
                                                  commenterId:  snapshot.data!["jobComments"][index]["userId"],
                                                  commenterName:  snapshot.data!["jobComments"][index]["name"],
                                                  commentBody:  snapshot.data!["jobComments"][index]["commentBody"],
                                                  commenterImageUrl:  snapshot.data!["jobComments"][index]["userImageUrl"],
                                                );
                                              },
                                              separatorBuilder: (context, index) {
                                                return Divider(
                                                  thickness: 1,
                                                  color: Colors.grey,
                                                );
                                              },
                                              itemCount: snapshot.data!["jobComments"].length,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
