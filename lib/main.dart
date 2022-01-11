import 'package:flutter/material.dart';

void main() => runApp(SpaceFinder());

class SpaceFinder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        appBar: AppBar(
          title: Text('Space Finder'),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}