import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/screens/homePage.dart';
import 'package:hilf/services/authentication.dart';
import 'package:hilf/services/firebaseOperations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'landingPageUtilities.dart';

class LandingServices with ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  void _formErrorToast(String message, Color _color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: _color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .userAvatar,
                    )),
                MaterialButton(
                    color: ConstantColors().accentColor,
                    onPressed: () {
                      Provider.of<LandingUtils>(context, listen: false)
                          .pickUserAvatar(context, ImageSource.gallery);
                    },
                    child: Text(
                      "Select Image",
                      style: TextStyle(color: Colors.white),
                    )),

                //confirm image
                MaterialButton(
                    color: ConstantColors().greenColor,
                    onPressed: () {
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .uploadUserAvatar(context)
                          .whenComplete(() {
                        signInSheet(context);
                      });
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          );
        });
  }

  Widget passWordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return ListView(
              children: snapshot.data.docs
                  .map((DocumentSnapshot documentSnapshot) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(documentSnapshot['userImage']),
                        ),
                        title: Text(documentSnapshot['userName']),
                        subtitle: Text(documentSnapshot['userEmail']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(
                        Provider.of<LandingUtils>(context, listen: false)
                            .getUserAvatar),
                    backgroundColor: Colors.green,
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          hintText: "Enter name",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: ConstantColors().greenColor,
                    onPressed: () {
                      if (userEmailController.text.isNotEmpty ||
                          userNameController.text.isNotEmpty) {
                        Provider.of<Authentication>(context, listen: false)
                            .registerAccount(userEmailController.text,
                                userPasswordController.text)
                            .whenComplete(() {
                          print("creating user collection");
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .createUserCollection(context, {
                            //sending data map
                            'userId': Provider.of<Authentication>(context,
                                    listen: false)
                                .getUserId,
                            'userName': userNameController.text,
                            'userEmail': userEmailController.text,
                            'userImage': Provider.of<LandingUtils>(context,
                                    listen: false)
                                .getUserAvatarUrl,
                          });
                        }).whenComplete(() => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.leftToRight)));
                      } else {
                        _formErrorToast(
                            "Please fill all field", ConstantColors().redColor);
                      }
                    },
                    child: Icon(Icons.check),
                  ),
                ],
              ),
            ),
          );
        });
  }

  registerSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          hintText: "Enter name",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          hintStyle: TextStyle(color: Color(0xffededed))),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: ConstantColors().blueColor,
                    onPressed: () {
                      if (userEmailController.text.isNotEmpty ||
                          userNameController.text.isNotEmpty) {
                        Provider.of<Authentication>(context, listen: false)
                            .logIntoAccount(userEmailController.text,
                                userPasswordController.text)
                            .whenComplete(() => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: HomePage(),
                                    type: PageTransitionType.leftToRight)));
                        ;
                      } else {
                        _formErrorToast(
                            "Please fill all field", ConstantColors().redColor);
                      }
                    },
                    child: Icon(Icons.check),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
