import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hilf/constants/Constantcolors.dart';
import 'package:hilf/screens/homePage.dart';
import 'package:hilf/services/authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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

  Widget passWordLessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("allUsers").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView(
              children: snapshot.data.docs
                  .map((DocumentSnapshot documentSnapshot) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              documentSnapshot[0].data()['userImage']),
                        ),
                        title: Text(documentSnapshot[0].data()['userName']),
                        subtitle: Text(documentSnapshot[0].data()['userEmail']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      ))
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
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
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
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
                            .whenComplete(() => Navigator.pushReplacement(
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
