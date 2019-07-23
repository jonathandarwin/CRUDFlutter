import 'package:flutter/material.dart';
import 'package:sqflite_example/home/home.dart';

void main() => runApp(Main());

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "SQFLite",
      home: HomeLayout(),
    );
  }
}