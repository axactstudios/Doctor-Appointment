import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctorAppointment/Widgets/custom_drawer.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';

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
    return new Scaffold(
      backgroundColor: Color(0xFFEFF7F6),
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text(
              "Your Details",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Name:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    newdp.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Degree:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    newdp.degree,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Specs:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    newdp.specs,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Address:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    newdp.address,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Cost:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    newdp.cost.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
