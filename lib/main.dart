import 'package:flutter/material.dart';
import 'package:flutter_compass_app/widgets/home.dart';
import 'package:screen/screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Screen.keepOn(true);

  runApp(
    MaterialApp(
      title: 'Talking Compass',
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
