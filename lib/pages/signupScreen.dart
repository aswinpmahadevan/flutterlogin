import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cropyield/controllers/authentications.dart';
import 'package:cropyield/pages/loginScreen.dart';
import 'package:cropyield/pages/home.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => home(uid: value.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFFc2ffca), const Color(0xFFc2ffca)],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, -200),
          child: Container(
            width: 563.0,
            height: 480.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7aff8c),
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
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Signup ",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              labelText: "Email"),
                          validator: (_val) {
                            if (_val.isEmpty) {
                              return "Can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(50.0),
                                  ),
                                ),
                                labelText: "Password"),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "This Field Is Required."),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required.")
                            ]),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          child: RaisedButton(
                            onPressed: handleSignup,
                            color: const Color(0xFF7aff8c),
                            textColor: Colors.black,
                            child: Text(
                              "Sign Up",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => googleSignIn().whenComplete(() async {
                    FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => home(uid: user.uid)));
                  }),
                  child: Image(
                    image: AssetImage('images/signin.png'),
                    width: 200.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    // send to login screen
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Login Here",
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
