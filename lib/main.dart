import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/helpers/landingPageHelper.dart';
import 'package:hilf/screens/splashScreen.dart';
import 'package:hilf/services/authentication.dart';
import 'package:hilf/services/landingServices.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    // statusBarIconBrightness: Brightness.dark,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(
          create: (_) => LandingServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => Authentication(),
        ),
      ],
    );
  }
}
