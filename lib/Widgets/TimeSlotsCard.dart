import 'package:doctorAppointment/Classes/Doc_data.dart';
import 'package:doctorAppointment/style/theme.dart';
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
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Slot ${index + 1}',
                style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: pHeight * 0.025,
                    color: MyColors.loginGradientEnd),
              ),
              SizedBox(
                height: pHeight * 0.01,
              ),
              Text(
                'From ${timeSlot.from}',
                style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: pHeight * 0.022,
                    color: MyColors.loginGradientEnd),
              ),
              Text(
                'To ${timeSlot.to}',
                style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: pHeight * 0.022,
                    color: MyColors.loginGradientEnd),
              ),
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
