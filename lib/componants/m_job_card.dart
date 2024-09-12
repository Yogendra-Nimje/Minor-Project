
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String status;
  final String timeAgo;

  const JobCard({
    Key? key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.status,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Image.asset(
              companyLogo,
              height: 40.0,
              width: 40.0,
            ),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.location_city,color: Colors.grey,),
                      const SizedBox(width: 5,),
                      Text(
                        companyName,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.query_builder,color: Colors.grey),
                      const SizedBox(width: 5,),
                      Text(
                        timeAgo,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(status,style: TextStyle(fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == "Sent" ? Colors.green[50] : status == "Pending" ? Colors.orange[50] : Colors.red[50],
                foregroundColor: status == "Sent" ? Colors.green : status == "Pending" ? Colors.orange : Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}