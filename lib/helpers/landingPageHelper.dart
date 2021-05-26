import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/screens/homePage.dart';
import 'package:hilf/services/authentication.dart';
import 'package:hilf/services/landingServices.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class LandingPageHelper with ChangeNotifier {
  ConstantColors _constantColors = ConstantColors();

  Widget bodyImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30),
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width - 220,
      decoration: BoxDecoration(
          // color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/images/cloud.png'),
              fit: BoxFit.fitWidth)),
    );
  }

  //tagline
  Widget tagLineText(BuildContext context) {
    return Positioned(
      top: 400,
      left: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Share your ideas",
              style: TextStyle(
                  fontSize: 31,
                  color: _constantColors.whiteColor,
                  fontWeight: FontWeight.bold)),
          Text("with your Tribe",
              style: TextStyle(
                  fontSize: 31,
                  color: Color(0xff79BEFF),
                  fontWeight: FontWeight.bold))
          // Container(
          //   // constraints: BoxConstraints(maxWidth: 500),
          //   child: RichText(
          //     text: TextSpan(
          //         text: "Share your ideas",
          //         style: TextStyle(
          //             fontSize: 40, color: _constantColors.whiteColor),
          //         children: <TextSpan>[
          //           TextSpan(
          //               text: "with your Tribe",
          //               style:
          //                   TextStyle(fontSize: 40, color: Color(0xff79BEFF)))
          //         ]),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget loginButtons(BuildContext context) {
    return Positioned(
      top: 520,
      left: 30,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  emailAuthSheet(context);
                },
                child: Container(
                  child: Icon(
                    Icons.email_outlined,
                    color: _constantColors.whiteColor,
                  ),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: _constantColors.whiteColor,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Material(
              child: InkWell(
                onTap: () {
                  print("signing in with google......");
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() => Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: HomePage(),
                              type: PageTransitionType.leftToRight)));
                },
                child: Container(
                  child: Icon(
                    EvaIcons.google,
                    color: _constantColors.whiteColor,
                  ),
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: _constantColors.whiteColor,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Icon(
                  EvaIcons.facebook,
                  color: _constantColors.whiteColor,
                ),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: _constantColors.whiteColor,
                    ),
                    borderRadius: BorderRadius.circular(50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  //bottom sheet
  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _constantColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Provider.of<LandingServices>(context, listen: false)
                    .passWordLessSignIn(context),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Provider.of<LandingServices>(context, listen: false)
                            .signInSheet(context);
                      },
                      child: Text("Log in"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Provider.of<LandingServices>(context, listen: false)
                            .registerSheet(context);
                      },
                      child: Text("Sign up"),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
