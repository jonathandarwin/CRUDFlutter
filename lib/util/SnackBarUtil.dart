import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarUtil{
  static void showSnackbar(BuildContext context, String text){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      )
    );
  }

  static void successSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Success"),
      )
    );
  }

  static void errorSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Error. Please try again"),
      )
    );
  }
}