import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/screens/LandingPage/landingPage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConstantColors _constantColors = ConstantColors();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingPage(), type: PageTransitionType.leftToRight)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _constantColors.whiteColor,
      body: Center(
        child: Text(
          "H",
          style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: _constantColors.accentColor),
        ),
      ),
    );
  }
}
