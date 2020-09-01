import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stdattendenceapp/Pages/signIn.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
        actions: [
          FlatButton(
            child: Text("Sign Out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            onPressed: dialogBox,
          )
        ],
      ),
      body: Builder(builder: (context){
        return ListView(
          children: [
            ListTile(
              title: const Text("Read Multiple Tags"),
              onTap: () {
                Navigator.pushNamed(context, "/read");
              },
            ),
            ListTile(
              title: const Text("Read Single Tag"),
              onTap: (){
                Navigator.pushNamed(context, "/readsingle");
              },
            )
          ],
        );
      },),
    );
  }


  void dialogBox(){
    showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Sign Out Alert"),
        content: Text("Are you sure you want to sign out"),
        actions: [
          FlatButton(child:Text("Sign Out"),onPressed: (){
            _signOut();
          },),
          FlatButton(child: Text("Cancel"),onPressed: (){
            Navigator.of(context).pop();
          },)
        ],
      );
    });
  }


  void _signOut(){
    FirebaseAuth.instance.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return LoginPage();
        }
      ));
    });
  }
}
