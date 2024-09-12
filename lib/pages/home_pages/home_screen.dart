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
            padding:  const EdgeInsets.symmetric(vertical: 8.0,horizontal: 6),
            child: Row(
              children: [
                Expanded(
                  child:Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for job',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
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

