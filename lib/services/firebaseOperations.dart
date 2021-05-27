import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilf/screens/LandingPage/landingPageUtilities.dart';
import 'package:hilf/services/authentication.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);

    await imageUploadTask.whenComplete(() => print("Image uploaded"));

    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          "The avatar url is ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}");
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserId)
        .set(data);
  }
}
