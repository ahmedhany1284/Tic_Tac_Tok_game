import 'package:flutter/material.dart';
import 'package:tic_tac_toc/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo ',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor:const Color(0xFF00061a) ,
        shadowColor:const Color(0xFF00145),
        splashColor: const Color(0xFF4169e9),
      ),
      home: const Home_page(),
    );
  }
}
