import 'dart:ffi';

import 'package:cropyield/pages/profile.dart';
import 'package:cropyield/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types
class home extends StatefulWidget {
  final String uid;
  home({Key key, @required this.uid}) : super(key: key);
  @override
  _homeState createState() => _homeState();
}

String city = '';
String yields = '';
String production = '';
String area = '';
final _formkey1 = GlobalKey<FormState>();
final _formkey = GlobalKey<FormState>();

Future<void> _savingData() async {
  final validation = _formkey.currentState.validate();

  if (!validation) {
    return;
  }

  _formkey.currentState.save();
  _formkey1.currentState.save();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF95E289),
      //   title: Text(
      //     "Home",
      //     style: TextStyle(
      //       fontFamily: "tepeno",
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
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
              Icons.home,
              size: 50,
            ),
          ),
          Transform.translate(
            offset: Offset(80, 115),
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 26,
                fontFamily: "tepeno",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(10, 290),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formkey,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          labelText: "City"),
                      onSaved: (val) {
                        city = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(yields),
                  Form(
                    key: _formkey1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          labelText: "Area"),
                      onSaved: (val) {
                        area = val;
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text("Predict yield"),
                    onPressed: () async {
                      _savingData();
                      // ignore: unused_local_variable
                      final response1 = await http.post(
                          'http://192.168.43.217:5000/',
                          body: json.encode({'city': city, 'area': area}));

                      // ignore: unused_local_variable

                      final response =
                          await http.get('http://192.168.43.217:5000/');
                      final decoded =
                          json.decode(response.body) as Map<String, dynamic>;
                      setState(() {
                        yields = decoded['response'];
                        production = decoded['production'];
                      });
                    },
                  ),
                  Text("PRODUCTION:"),
                  Text(
                    production == null ? ' ' : production,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "tepeno",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text("\nPREDICTED YIELD:"),
                  new Text(
                    yields == null ? ' ' : yields,
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: "tepeno",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              color: const Color(0xFF95E289),
              child: RaisedButton(
                color: const Color(0xFF95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => home()));
                },
                child: IconButton(
                    icon: Icon(Icons.home),
                    color: const Color(0xFF95E289),
                    iconSize: 50,
                    onPressed: null),
              ),
            ),
            Container(
              width: 130,
              color: const Color(0xFF95E289),
              child: RaisedButton(
                color: const Color(0xFF95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => profile()));
                },
                child: IconButton(
                    icon: Icon(Icons.person),
                    color: const Color(0xFF95E289),
                    iconSize: 50,
                    onPressed: null),
              ),
            ),
            Container(
              width: 130,
              color: const Color(0xFF95E289),
              child: RaisedButton(
                color: const Color(0xFF95E289),
                onPressed: () {
                  // send to login screen
                  Navigator.of(context).push(MaterialPageRoute(
                      // ignore: missing_required_param
                      builder: (context) => settings()));
                },
                child: IconButton(
                    icon: Icon(Icons.settings),
                    color: const Color(0xFF95E289),
                    iconSize: 50,
                    onPressed: null),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
