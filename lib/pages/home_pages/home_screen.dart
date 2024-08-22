import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../componants/job_card.dart';
import "package:intl/intl.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Method to get the current date formatted
  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('EEEE, dd MMMM yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          // Prepare for your job search
          // Card(
          //   elevation: 2,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: ListTile(
          //
          //     contentPadding: const EdgeInsets.all(16.0),
          //     title: const Text('Prepare for your job search'),
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const SizedBox(height: 4.0),
          //         const Text('Add additional details from your profile any time.'),
          //         const SizedBox(height: 8.0),
          //         LinearProgressIndicator(
          //           value: 0.5,
          //           backgroundColor: Colors.grey[300],
          //           color: Colors.green,
          //         ),
          //         const SizedBox(height: 4.0),
          //         const Text('2/4 Complete'),
          //       ],
          //     ),
          //     trailing: const Icon(Icons.more_vert),
          //   ),
          // ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getCurrentDate(), // Display today's date
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Text(
                    "Search, Find, and Apply",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              const Expanded(child: Icon(CupertinoIcons.bell))
            ],
          ),
          // Search Bar
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          height: 30,
                          child: Icon(Icons.search,color: Colors.grey[700],),
                  
                        ),
                        ),
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                              fillColor: Theme.of(context).colorScheme.inversePrimary,
                              border: InputBorder.none,
                              hintText: "search for job..",
                          ),
                        ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          // Job Listings
          const JobCard(
            company: "Google, Inc.",
            jobTitle: "Agency Business Lead",
            description:
            "Businesses that partner with Google come in all shapes, sizes and market caps, and no one Google advertising solution works for all.",
            daysAgo: "4 days ago",
            applicants: "240 Applicants",
            logoAsset: 'lib/assets/google.png', // Path to the Google logo asset
          ),

          const SizedBox(height: 16.0),

          const JobCard(
            company: "Twitter, Inc.",
            jobTitle: "Senior Product Manager",
            description:
            "Twitter promotes and protects the public conversation.",
            daysAgo: "1 day ago",
            applicants: "150 Applicants",
            logoAsset: 'lib/assets/icon_chat.png', // path of image path
          ),
        ],
    );
  }
}
