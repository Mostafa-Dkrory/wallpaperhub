import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home.dart';
import 'screens/onboarding2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  Widget _screen = OnBoarding();
  if (seen == true) {
    _screen = Home();
  } else {
    _screen = OnBoarding();
  }
  runApp(MyApp(_screen));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget _screen;
  MyApp(this._screen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WallpaperHub',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: this._screen,
    );
  }
}
