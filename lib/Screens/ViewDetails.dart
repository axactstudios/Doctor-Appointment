import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:doctorAppointment/style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
Docpro newdp = new Docpro();

class _ViewDetailsState extends State<ViewDetails>
    with TickerProviderStateMixin {
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
  void getData() async {
    //newdp.clear();
    await docdatabaseReference
        .collection("Doctors")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) async {
        List<TimeSlots> timeArr = new List<TimeSlots>();
        //Array of all TimeSlots

        List.from(doc["TimeSlots"]).forEach((element) async {
          TimeSlots newTime = TimeSlots(
            from: element['From'],
            to: element['To'],
            available: element['Available'],
          );

          await timeArr.add(newTime);
        });

        if (doc["ID"] == user.uid) {
          newdp.address = await doc['address'];
          newdp.imageUrl = 'images/Doc2.png';
          newdp.name = await doc['name'];
          newdp.specs = await doc['specs'];
          newdp.degree = await doc['degree'];
          newdp.cost = await doc['cost'];
          newdp.slots = timeArr;
          newdp.docId = await doc['ID'];
          print('---------DOC ID ${newdp.docId}------------');

          print("doc added");
        }
      });
    });
    setState(() {
      //print(docpros.length.toString());
    });
  }

  final databaseReference = Firestore.instance;

  @override
  void initState() {
    getUser();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Container(
        height: pHeight,
        width: pWidth,
        child: newdp.name == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Text(
                      'Your Profile',
                      style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: pHeight * 0.035,
                        color: MyColors.loginGradientEnd,
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Card(
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
                          child: Container(
                            width: pWidth * 0.85,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Name :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                                SizedBox(
                                  width: pWidth * 0.05,
                                ),
                                Text(
                                  newdp.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Card(
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
                          child: Container(
                            width: pWidth * 0.85,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Degree :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                                SizedBox(
                                  width: pWidth * 0.05,
                                ),
                                Text(
                                  newdp.degree,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Card(
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
                          child: Container(
                            width: pWidth * 0.85,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Specialization :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                                SizedBox(
                                  width: pWidth * 0.05,
                                ),
                                Text(
                                  newdp.specs,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Card(
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
                          child: Container(
                            width: pWidth * 0.85,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Address :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                                SizedBox(
                                  width: pWidth * 0.05,
                                ),
                                Text(
                                  newdp.address,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: pHeight * 0.02,
                    ),
                    Card(
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
                          child: Container(
                            width: pWidth * 0.85,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Cost :',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                                SizedBox(
                                  width: pWidth * 0.05,
                                ),
                                Text(
                                  newdp.cost.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Cabin',
                                      fontSize: pHeight * 0.025),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
