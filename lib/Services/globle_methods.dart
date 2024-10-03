import 'dart:ffi';

import 'package:flutter/material.dart';

class GlobleMethods {
  static void ShowErrorDialog({required String error, required BuildContext ctx}){
    showDialog(
      context: ctx,
      builder: (context){
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.grey[500],
                  size: 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Error Occurred"),
              ),
            ],
          ),
          content: Text(
            error,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      }
    );
  }
}