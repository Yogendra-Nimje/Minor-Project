import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String company;
  final String jobTitle;
  final String description;
  final String daysAgo;
  final String applicants;
  final String logoAsset; // image path

  const JobCard({super.key,
    required this.company,
    required this.jobTitle,
    required this.description,
    required this.daysAgo,
    required this.applicants,
    required this.logoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(logoAsset), // Circular image
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(company),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(description),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4.0),
                Text(daysAgo),
                const SizedBox(width: 16.0),
                const Icon(Icons.group, size: 16, color: Colors.grey),
                const SizedBox(width: 4.0),
                Text(applicants),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
