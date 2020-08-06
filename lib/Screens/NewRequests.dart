import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Request.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewRequests extends StatefulWidget {
  @override
  _NewRequestsState createState() => _NewRequestsState();
}

class _NewRequestsState extends State<NewRequests> {
  final firestoreInstance = Firestore.instance.collection('DoctorAppointment');

  List<Request> newReq = [];

  void getRequests() async {
    newReq.clear();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .where('doctorUID', isEqualTo: user.uid)
        .getDocuments()
        .then((req) {
      req.documents.forEach((request) async {
        Request newRequest = Request();
        newRequest.reqID = await request.documentID;
        print(newRequest.reqID);
        newRequest.appDate = await request['appointmentDate'];
        newRequest.bookDate = await request['bookingDate'];
        newRequest.bookTime = await request['bookingTime'];
        newRequest.dogAge = await request['dogAge'];
        newRequest.dogBreed = await request['dogBreed'];
        newRequest.dogName = await request['dogName'];
        newRequest.from = await request['from'];
        newRequest.ownerEmail = await request['ownerEmail'];
        newRequest.ownerName = await request['ownerName'];
        newRequest.ownerPhone = await request['ownerPhone'];
        newRequest.to = await request['to'];
        print(
            '----${newRequest.appDate} for ${newRequest.dogName} owner name : ${newRequest.ownerName}-----');
        bool isConfirmed;
        isConfirmed = await request['isConfirmed'];
        String status;
        status = await request['status'];
        if (!isConfirmed && status == 'Booked') {
          newReq.add(newRequest);
        }
      });
      setState(() {
        print(newReq.length);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getRequests();
  }

  void accept(String appId) {
    firestoreInstance.document(appId).updateData({"isConfirmed": true});
    getRequests();
  }

  void reject(String appId) {
    firestoreInstance.document(appId).updateData({"status": 'Rejected'});
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: newReq.length == 0
          ? Center(
              child: Text(
                'No new requests',
                style: TextStyle(fontSize: pHeight * 0.025),
              ),
            )
          : ListView.builder(
              itemCount: newReq.length,
              itemBuilder: (context, index) {
                var item = newReq[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    margin: EdgeInsets.only(top: 15),
                    elevation: 3,
                    child: Container(
                      width: pWidth * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: Colors.purple,
                                      size: pHeight * 0.075,
                                    ),
                                    SizedBox(
                                      width: pWidth * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.ownerName,
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: pHeight * 0.03),
                                        ),
                                        Text(
                                          item.ownerPhone,
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: pHeight * 0.022),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          item.dogName,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: pHeight * 0.03),
                                        ),
                                        Text(
                                          item.dogBreed,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: pHeight * 0.025),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: pWidth * 0.02,
                                    ),
                                    Icon(
                                      Icons.pets,
                                      color: Colors.blue,
                                      size: pHeight * 0.075,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: pHeight * 0.02,
                            ),
                            Text(
                              'Appointment Date : ${item.appDate}',
                              style: TextStyle(
                                fontSize: pHeight * 0.02,
                              ),
                            ),
                            SizedBox(
                              height: pHeight * 0.005,
                            ),
                            Text(
                              'Appointment Slot : ${item.from} - ${item.to}',
                              style: TextStyle(
                                fontSize: pHeight * 0.02,
                              ),
                            ),
                            SizedBox(
                              height: pHeight * 0.02,
                            ),
                            Text(
                              'Booking Date : ${item.bookDate}',
                              style: TextStyle(
                                fontSize: pHeight * 0.016,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                            SizedBox(
                              height: pHeight * 0.005,
                            ),
                            Text(
                              'Booking Time : ${item.bookTime}',
                              style: TextStyle(
                                fontSize: pHeight * 0.016,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                            SizedBox(
                              height: pHeight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    accept(item.reqID);
                                  },
                                  color: Colors.green,
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: pWidth * 0.1,
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    reject(item.reqID);
                                  },
                                  color: Colors.red,
                                  child: Text(
                                    'Decline',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
