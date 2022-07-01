import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';

import 'home.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoarding> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _globalKey,
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: const Color(0xFFf74269),
        pages: pages,
        skipClicked: (value) {
          print(value);
          _updateSeen();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Home()));
          // _globalKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Skip clicked"),
          // ));
        },
        getStartedClicked: (value) {
          print(value);
          _updateSeen();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
          // _globalKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Get Started clicked"),
          // ));
        },
      ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Welcome ',
        description:
            'We provides high quality and completely free stock photos.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'lib/assets/png.png'),
    SkOnboardingModel(
        title: 'Pick Up and Save',
        description:
            'Download free hundreds of every day new high resolution photos',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'lib/assets/tenor.gif'),
    SkOnboardingModel(
        title: 'Enjoy our community',
        description:
            'We make sure all published pictures are licensed under the Pexels license.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'lib/assets/tenor (1).gif'),
  ];

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true); // TODO: make it true to see OnBoarding once
  }
}
