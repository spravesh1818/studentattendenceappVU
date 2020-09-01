import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stdattendenceapp/Pages/loginPage.dart';
import 'package:stdattendenceapp/Pages/nfcReader.dart';
import 'package:stdattendenceapp/Pages/practiceStream.dart';

import 'Pages/signIn.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/read": (context) => NfcReaderStreamer(),
        "/readsingle":(context)=>NfcReaderImple()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: LoginPage()),
    );
  }
}


