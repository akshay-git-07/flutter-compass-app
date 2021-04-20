import 'package:flutter/material.dart';
import 'package:flutter_compass_app/widgets/home.dart';
import 'package:screen/screen.dart';

void main() {
  Screen.keepOn(true);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Color(0xFFFF00FF),
      // ),
      // theme: ThemeData.dark(),
      home: Home(),
    ),
  );
}
