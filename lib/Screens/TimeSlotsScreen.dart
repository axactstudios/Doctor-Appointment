import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/Widgets/TimeSlotsCard.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSlotsScreen extends StatefulWidget {
  @override
  _TimeSlotsScreenState createState() => _TimeSlotsScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
Docpro newdp = new Docpro();

class _TimeSlotsScreenState extends State<TimeSlotsScreen>
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

  final databaseReference = Firestore.instance;
  final docdatabaseReference = Firestore.instance;
  TextEditingController taskFromInputController;
  TextEditingController taskToInputController;

  void getData() async {
    //newdp.clear();
    await docdatabaseReference
        .collection("Doctors")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) async {
        //Array of all TimeSlots
        List<TimeSlots> timeArr = new List<TimeSlots>();

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
          newdp.cost = await int.parse(doc['cost']);
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

  @override
  void initState() {
    getUser();
    getData();
    taskFromInputController = new TextEditingController();
    taskToInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Doctors').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView.builder(
                    itemCount: newdp.slots.length,
                    itemBuilder: (context, index) {
                      return TimeSlotsCard(
                        timeSlot: TimeSlots(
                          from: (newdp.slots[index]).from,
                          to: (newdp.slots[index]).to,
                          available: (newdp.slots[index]).available,
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          height: 170,
          child: Column(
            children: <Widget>[
              Text("Please fill the details for a new slot"),
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'From'),
                controller: taskFromInputController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'To'),
                controller: taskToInputController,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                taskFromInputController.clear();
                taskToInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () {
                if (taskFromInputController.text.isNotEmpty &&
                    taskToInputController.text.isNotEmpty) {
                  Firestore.instance
                      .collection('Doctors')
                      .add({
                        "TimeSlots": [
                          taskFromInputController.text,
                          taskToInputController.text,
                          "Yes"
                        ],
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskFromInputController.clear(),
                            taskToInputController.clear(),
                          })
                      .catchError((err) => print(err));
                }
              })
        ],
      ),
    );
  }
}
