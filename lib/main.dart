import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/helpers/landingPageHelper.dart';
import 'package:hilf/screens/splashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ConstantColors _constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            accentColor: _constantColors.accentColor,
            fontFamily: 'Poppins',
            canvasColor: Colors.transparent),
        home: SplashScreen(),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => LandingPageHelper(),
        ),
      ],
    );
  }
}
