import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/screens/LandingPage/landingPageHelper.dart';
import 'package:hilf/screens/LandingPage/landingServices.dart';
import 'package:hilf/services/firebaseOperations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;

  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar =
        await picker.getImage(source: source); //source = gallery/camera etc
    pickedUserAvatar == null
        ? print("Select image")
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingServices>(context, listen: false)
            .showUserAvatar(context)
        : print("image upload error");

    notifyListeners();
  }

  Future selectAvatarOptionSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Divider(),
                MaterialButton(
                  onPressed: () {
                    pickUserAvatar(context, ImageSource.gallery)
                        .whenComplete(() {
                      Navigator.pop(context);
                      Provider.of<LandingServices>(context, listen: false)
                          .showUserAvatar(context);
                    });
                  },
                  color: ConstantColors().accentColor,
                  child: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                //capturing from camera
                MaterialButton(
                  onPressed: () {
                    pickUserAvatar(context, ImageSource.camera)
                        .whenComplete(() {
                      Navigator.pop(context);
                      Provider.of<LandingServices>(context, listen: false)
                          .showUserAvatar(context);
                    });
                  },
                  color: ConstantColors().accentColor,
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        });
  }
}
