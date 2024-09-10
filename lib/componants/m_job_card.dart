
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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              companyLogo,
              height: 40.0,
              width: 40.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    companyName,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(status),
              style: ElevatedButton.styleFrom(
                primary: status == "Sent" ? Colors.green : status == "Pending" ? Colors.orange : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}