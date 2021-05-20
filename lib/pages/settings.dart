import 'package:cropyield/pages/profile.dart';
import 'package:cropyield/pages/home.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

// ignore: camel_case_types
class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.exit_to_app),
      //       splashColor: Colors.transparent,
      //       highlightColor: Colors.transparent,
      //       onPressed: () => signOutUser().then((value) {
      //         Navigator.of(context).pushAndRemoveUntil(
      //             MaterialPageRoute(builder: (context) => HomePage()),
      //             (Route<dynamic> route) => false);
      //       }),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, -200),
            child: Container(
              width: 500.0,
              height: 500.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF95E289),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x242f595),
                    offset: Offset(-55, -55),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(30, 100),
            child: Icon(
              Icons.settings,
              size: 50,
            ),
          ),
          Transform.translate(
            offset: Offset(80, 110),
            child: Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "tepeno",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              color: Color(0xFF95E289),
              child: RaisedButton(
                color: Color(0xFF95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => home()));
                },
                child: IconButton(
                    icon: Icon(Icons.home),
                    color: Color(0xFF95E289),
                    iconSize: 50,
                    onPressed: null),
              ),
            ),
            Container(
              width: 130,
              color: Color(0xFF95E289),
              child: RaisedButton(
                color: Color(0xFF95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => profile()));
                },
                child: IconButton(
                    icon: Icon(Icons.person),
                    color: Color(0xFF95E289),
                    iconSize: 50,
                    onPressed: null),
              ),
            ),
            Container(
              width: 130,
              color: Color(0xFF95E289),
              child: RaisedButton(
                color: Color(0xff95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => settings()));
                },
                child: IconButton(
                    icon: Icon(Icons.settings),
                    iconSize: 50,
                    color: Color(0xFF95E289),
                    onPressed: null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
