import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:stdattendenceapp/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _buttonEnabled = true;
  Widget _buttonTextWidget = Text(
    "Sign In",
    style: TextStyle(
      fontSize: 24
    ),
  );
  Widget _buttonLoadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Form(
            key: _formkey,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                contentPadding: EdgeInsets.all(20),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Email is required';
                              }
                            },
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password',
                                contentPadding: EdgeInsets.all(20),
                                labelStyle:
                                TextStyle(fontWeight: FontWeight.bold)),
                            obscureText: true,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Password is required';
                              }
                            },
                            onSaved: (input) => _password = input,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _buttonEnabled?Colors.blueAccent:Colors.white,
                          ),
                          child: FlatButton(
                              textColor: Colors.white,
                              onPressed: _buttonEnabled ? signIn : null,
                              child: _buttonEnabled
                                  ? _buttonTextWidget
                                  : _buttonLoadingWidget),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  void signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      setState(() {
        _buttonEnabled = false;
      });
      formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        }));
      } catch (e) {
        print(e.message);
        setState(() {
          _buttonEnabled = true;
        });
      }
    }
    //login to firebase
  }
}
