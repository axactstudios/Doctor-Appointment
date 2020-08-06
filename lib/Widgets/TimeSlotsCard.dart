import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/Screens/TimeSlotsScreen.dart';
import 'package:doctorAppointment/style/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSlotsCard extends StatelessWidget {
  TimeSlotsCard({@required this.timeSlot, this.index});

  int index;
  final TimeSlots timeSlot;

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
            colors: [MyColors.loginGradientEnd, MyColors.loginGradientStart],
          ),
        ),
        padding: const EdgeInsets.only(top: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: pWidth * 0.12,
                  ),
                  Text(
                    'Slot ${index + 1}',
                    style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: pHeight * 0.025,
                        color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      FirebaseUser user =
                          await FirebaseAuth.instance.currentUser();
                      await Firestore.instance
                          .collection('Doctors')
                          .document(user.uid)
                          .updateData({
                        'TimeSlots': FieldValue.arrayRemove([
                          {
                            'Available': 'Yes',
                            'From': timeSlot.from,
                            'To': timeSlot.to
                          }
                        ])
                      }).then((result) {
                        print('Removed');
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimeSlotsScreen(),
                          ),
                        );
                      }).catchError((err) => print(err));
                    },
                  )
                ],
              ),
              SizedBox(
                height: pHeight * 0.01,
              ),
              Text(
                'From ${timeSlot.from}',
                style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: pHeight * 0.022,
                    color: CupertinoColors.white),
              ),
              Text(
                'To ${timeSlot.to}',
                style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: pHeight * 0.022,
                    color: Colors.white),
              ),
              SizedBox(
                height: pHeight * 0.01,
              )
              //Text(to),
              // FlatButton(
              //     child: Text("See More"),
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => SecondPage(
              //                   title: title, description: description)));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
