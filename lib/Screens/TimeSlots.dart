import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/TimeSlotsData.dart';
import 'package:doctorAppointment/Widgets/TimeSlotsCard.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSlots extends StatefulWidget {
  @override
  _TimeSlotsState createState() => _TimeSlotsState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;

class _TimeSlotsState extends State<TimeSlots> with TickerProviderStateMixin {
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
  TextEditingController taskFromInputController;
  TextEditingController taskToInputController;
  List<TimeSlotsData> timeSlots;

  @override
  void initState() {
    getUser();
    //getSlots();
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
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    List.from(document['TimeSlots']).forEach((element) {
                      timeSlots.add(TimeSlotsData.fromMap(element));
                      print(timeSlots);
                    });
                  });
                  return new ListView.builder(
                    //itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      return TimeSlotsCard(
                        timeSlot: TimeSlotsData(
                          (timeSlots[index]).from,
                          (timeSlots[index]).to,
                          (timeSlots[index]).available,
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
                          taskToInputController.text
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
