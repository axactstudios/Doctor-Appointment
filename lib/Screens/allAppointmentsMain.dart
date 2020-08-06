import 'package:doctorAppointment/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:doctorAppointment/Screens/appointmentPast.dart';
import 'package:doctorAppointment/Widgets/appbar.dart';
import 'package:doctorAppointment/Screens/appointmentFuture.dart';

class AppointmentMainPage extends StatefulWidget {
  @override
  _AppointmentMainPageState createState() => _AppointmentMainPageState();
}

class _AppointmentMainPageState extends State<AppointmentMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          // action: IconButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AlertDialog(
          //             title: Text("Add a dog"),
          //             actions: [
          //               FlatButton(
          //                 child: Text("For Adoption"),
          //                 onPressed: () {
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (BuildContext context) =>
          //                           AddDogAdopt()));
          //                 },
          //               ),
          //               FlatButton(
          //                 child: Text("For sale"),
          //                 onPressed: () {
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (BuildContext context) => AddDogSell()));
          //                 },
          //               )
          //             ],
          //           );
          //         });
          //   },
          //   icon: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          // ),
          ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        height: double.infinity,
        child: GFTabs(
          tabBarColor: MyColors.loginGradientEnd,
          tabBarHeight: 70,
          indicatorColor: Colors.white,

          initialIndex: 0,
          length: 2,
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(
//              bottomRight: Radius.circular(10),
//              bottomLeft: Radius.circular(10))),
          tabs: <Widget>[
            Tab(
              child: Text(
                "Coming Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ),
            Tab(
              child: Text(
                "Past",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "nunito",
                ),
              ),
            ),
          ],
          tabBarView: GFTabBarView(
            children: <Widget>[FutureAppointment(), PastAppointment()],
          ),
        ),
      )),
    );
  }
}
