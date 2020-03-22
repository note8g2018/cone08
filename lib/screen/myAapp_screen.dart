import 'package:cone08/screen/home_screen.dart';
import 'package:cone08/screen/reg_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //      theme: ThemeData.dark(),
      initialRoute: LogIn.route,
      routes: {
        LogIn.route: (context) => LogIn(),
        RegScreen.route: (context) => RegScreen(),
        Home.route: (context) => Home(),
      },
    );
  }
}
