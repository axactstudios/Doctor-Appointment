import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/Screens/DoctorBasicDetails.dart';
import 'package:doctorAppointment/Screens/ViewDetails.dart';
import 'package:doctorAppointment/style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctorAppointment/Widgets/custom_drawer.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'TimeSlotsScreen.dart';
import 'allAppointmentsMain.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
Docpro newdp = new Docpro();

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int number = 0;
  int max = 10;
  FirebaseUser user;
  void getUser() async {
    user = await auth.currentUser();
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  final docdatabaseReference = Firestore.instance;

  final databaseReference = Firestore.instance;

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return new Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Container(
        width: pWidth,
        height: pHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDetails(),
                  ),
                );
              },
              child: Container(
                width: pWidth * 0.85,
                height: pHeight * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: new LinearGradient(
                        colors: [
                          MyColors.loginGradientStart,
                          MyColors.loginGradientEnd
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            size: pHeight * 0.07,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: pHeight * 0.025,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: pHeight * 0.02,
            ),
            InkWell(
              child: Container(
                width: pWidth * 0.85,
                height: pHeight * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: new LinearGradient(
                        colors: [
                          MyColors.loginGradientStart,
                          MyColors.loginGradientEnd
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            size: pHeight * 0.07,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'New Requests',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: pHeight * 0.025,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: pHeight * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentMainPage(),
                  ),
                );
              },
              child: Container(
                width: pWidth * 0.85,
                height: pHeight * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: new LinearGradient(
                        colors: [
                          MyColors.loginGradientStart,
                          MyColors.loginGradientEnd
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.alarm,
                            size: pHeight * 0.07,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'Bookings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: pHeight * 0.025,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: pHeight * 0.02,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeSlotsScreen(),
                  ),
                );
              },
              child: Container(
                width: pWidth * 0.85,
                height: pHeight * 0.15,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: new LinearGradient(
                        colors: [
                          MyColors.loginGradientStart,
                          MyColors.loginGradientEnd
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.update,
                            size: pHeight * 0.07,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: pHeight * 0.01,
                          ),
                          Text(
                            'Update Slots',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: pHeight * 0.025,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
