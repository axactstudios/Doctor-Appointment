import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctorAppointment/Screens/FirstScreen.dart';
import 'package:doctorAppointment/Classes/Constants.dart';

class DoctorBasicDetails extends StatefulWidget {
  final String phno;

  const DoctorBasicDetails({Key key, this.phno}) : super(key: key);
  @override
  _DoctorBasicDetailsState createState() => _DoctorBasicDetailsState();
}

class _DoctorBasicDetailsState extends State<DoctorBasicDetails> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  final myController = TextEditingController();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    myController.dispose();

    super.dispose();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    setState(() {
      user = _user;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Form(
            key: formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      hintText: 'Full Name',
                      hintStyle: TextStyle(
                        color: kTextColor.withOpacity(0.65),
                      ),
                    ),
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'This field cannot be blank';
                      } else
                        return null;
                    },
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.85),
                        fontSize: 20.0,
                        fontFamily: 'Cabin'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController1,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      hintText: 'Address',
                      hintStyle: TextStyle(
                        color: kTextColor.withOpacity(0.65),
                      ),
                    ),
                    validator: (line1) {
                      if (line1.isEmpty) {
                        return 'This field cannot be blank';
                      } else
                        return null;
                    },
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.85),
                        fontSize: 20.0,
                        fontFamily: 'Cabin'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController2,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      hintText: 'Degree',
                      hintStyle: TextStyle(
                        color: kTextColor.withOpacity(0.65),
                      ),
                    ),
                    validator: (line2) {
                      if (line2.isEmpty) {
                        return 'This field cannot be blank';
                      } else
                        return null;
                    },
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.85),
                        fontSize: 20.0,
                        fontFamily: 'Cabin'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController3,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      hintText: 'Specs',
                      hintStyle: TextStyle(
                        color: kTextColor.withOpacity(0.65),
                      ),
                    ),
                    validator: (pincode) {
                      if (pincode.isEmpty) {
                        return 'This field cannot be blank';
                      } else
                        return null;
                    },
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.85),
                        fontSize: 20.0,
                        fontFamily: 'Cabin'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController4,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 2.0),
                      ),
                      hintText: 'Cost',
                      hintStyle: TextStyle(
                        color: kTextColor.withOpacity(0.65),
                      ),
                    ),
                    validator: (pincode) {
                      if (pincode.isEmpty) {
                        return 'This field cannot be blank';
                      } else
                        return null;
                    },
                    style: TextStyle(
                        color: kTextColor.withOpacity(0.85),
                        fontSize: 20.0,
                        fontFamily: 'Cabin'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseUser user = await mAuth.currentUser();

                      if (formKey.currentState.validate()) {
                        print(widget.phno);
                        final databaseReference = Firestore.instance;
                        databaseReference
                            .collection('Doctors')
                            .document(user.uid)
                            .setData({
                          "name": myController.text,
                          "address": myController1.text,
                          'degree': myController2.text,
                          'specs': myController3.text,
                          'ID': user.uid,
                          'TimeSlots': "",
                          "cost": myController4.text,
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirstScreen()),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 34.0),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text(
                        'SAVE',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 20.0, color: kWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
