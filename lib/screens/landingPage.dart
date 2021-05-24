import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/helpers/landingPageHelper.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  ConstantColors _constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _constantColors.whiteColor,
        body: Stack(
          children: [
            bodyColor(),
            Provider.of<LandingPageHelper>(context, listen: false).bodyImage(
                context), //here listen= false becauser we are not rendering the Ui, we are simply reading it
            Provider.of<LandingPageHelper>(context, listen: false)
                .tagLineText(context),
            Provider.of<LandingPageHelper>(context, listen: false)
                .loginButtons(context)
          ],
        ));
  }

  bodyColor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.9],
              colors: [_constantColors.accentColor, Color(0xff0084FF)])),
    );
  }
}
