import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:flutter/material.dart';

class TimeSlotsCard extends StatelessWidget {
  TimeSlotsCard({@required this.timeSlot});

  final TimeSlots timeSlot;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: <Widget>[
            Text(timeSlot.from),
            Text(timeSlot.to),
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
    );
  }
}
