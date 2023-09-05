import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

void showCustomSnackbar(BuildContext context, String message) {
  final snackbar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(20),
    duration: Duration(seconds: 5),
    elevation: 8,
    backgroundColor: Colors.red,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
