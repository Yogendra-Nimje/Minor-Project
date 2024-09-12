import 'package:flutter/material.dart';
import 'package:find_in/componants/m_job_card.dart'; // Make sure the path to your component is correct

class AppliedScreen extends StatelessWidget {
  const AppliedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Applied",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 10,),
            Expanded(
              child: ListView(
                children: const [
                  JobCard(
                    companyLogo: "lib/assets/google.png",
                    companyName: "Google, Inc.",
                    jobTitle: "UX/UI Designer",
                    status: "Sent",
                    timeAgo: "2 Days Ago",
                  ),

                  JobCard(
                    companyLogo: "lib/assets/figma_5968705.png",
                    companyName: "Figma",
                    jobTitle: "Business Lead",
                    status: "Pending",
                    timeAgo: "9 Days ago",
                  ),
                  JobCard(
                    companyLogo: "lib/assets/social_14449860.png",
                    companyName: "Pintrest",
                    jobTitle: "Graphics Designer",
                    status: "Rejected",
                    timeAgo: "27 Days Ago",
                  ),

                  JobCard(
                    companyLogo: "lib/assets/google.png",
                    companyName: "Google, Inc.",
                    jobTitle: "Senior Product Manager",
                    status: "Rejected",
                    timeAgo: "35 Days Ago",
                  ),

                  JobCard(
                    companyLogo: "lib/assets/figma_5968705.png",
                    companyName: "Figma",
                    jobTitle: "Business Lead",
                    status: "Pending",
                    timeAgo: "9 Days ago",
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
