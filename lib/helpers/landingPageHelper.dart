import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
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
                onTap: () {},
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
                onTap: () {},
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
}
