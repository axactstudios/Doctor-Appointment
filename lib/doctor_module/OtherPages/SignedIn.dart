import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctorAppointment/Screens/DoctorBasicDetails.dart';
import 'package:doctorAppointment/Classes/Constants.dart';
import 'package:doctorAppointment/style/theme.dart' as Theme;

class SignedIn extends StatefulWidget {
  String phNo;

  SignedIn({this.phNo});

  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn> {
  getDatabaseRef() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var document = await Firestore
        .instance //Used the UID of the user to check if record exists in the database or not
        .collection('Doctors')
        .document(user.uid)
        .get();

    if (document.data == null) {
      print("Null");
      setState(() {
        isStored = false;
      });
    } else {
      print("Has data");
      setState(() {
        isStored = true;
      });
    }
  }

  bool isStored = false;

  @override
  void initState() {
    getDatabaseRef();
    new Future.delayed(Duration(seconds: 3), () {
      if (isStored) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        print(widget.phNo);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorBasicDetails(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                Theme.MyColors.loginGradientStart,
                Theme.MyColors.loginGradientEnd
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/signed in.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Signed In',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Cabin'),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Redirecting...',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Cabin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
