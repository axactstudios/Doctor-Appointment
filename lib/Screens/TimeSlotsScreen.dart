import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/Widgets/TimeSlotsCard.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TimeSlotsScreen extends StatefulWidget {
  @override
  _TimeSlotsScreenState createState() => _TimeSlotsScreenState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
String uid;
Docpro newdp = new Docpro();

class _TimeSlotsScreenState extends State<TimeSlotsScreen>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  bool _dialVisible = true;
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
        List<TimeSlots> timeArr = new List<TimeSlots>();
        //Array of all TimeSlots
        // print(doc["TimeSlots"]);

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

  void setDialVisible(bool value) {
    setState(() {
      _dialVisible = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animationController.dispose() instead of your controller.dispose
  }

  @override
  void initState() {
    getUser();
    getData();
    taskFromInputController = new TextEditingController();
    taskToInputController = new TextEditingController();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
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
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
              label: 'Remove',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => _showRemDialog()),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: 'Add',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => _showDialog(),
          ),
        ],
      ),
    );
  }

  _showRemDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
          height: 170,
          child: Column(
            children: <Widget>[
              Text("Please fill the details to remove a slot"),
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
              child: Text('Remove'),
              onPressed: () async {
                if (taskFromInputController.text.isNotEmpty &&
                    taskToInputController.text.isNotEmpty) {
                  await Firestore.instance
                      .collection('Doctors')
                      .document(user.uid)
                      .updateData({
                        'TimeSlots': FieldValue.arrayRemove([
                          {
                            'Available': 'Yes',
                            'From': taskFromInputController.text,
                            'To': taskToInputController.text
                          }
                        ])
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskFromInputController.clear(),
                            taskToInputController.clear(),
                          })
                      .catchError((err) => print(err));
                  setState(() {
                    initState();
                  });
                }
              })
        ],
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
              onPressed: () async {
                if (taskFromInputController.text.isNotEmpty &&
                    taskToInputController.text.isNotEmpty) {
                  await Firestore.instance
                      .collection('Doctors')
                      .document(user.uid)
                      .updateData({
                        'TimeSlots': FieldValue.arrayUnion([
                          {
                            'Available': 'Yes',
                            'From': taskFromInputController.text,
                            'To': taskToInputController.text
                          }
                        ])
                      })
                      .then((result) => {
                            Navigator.pop(context),
                            taskFromInputController.clear(),
                            taskToInputController.clear(),
                          })
                      .catchError((err) => print(err));
                  setState(() {
                    initState();
                  });
                }
              })
        ],
      ),
    );
  }
}
