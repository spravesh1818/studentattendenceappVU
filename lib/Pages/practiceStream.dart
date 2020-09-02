import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NfcReaderStreamer extends StatefulWidget {
  @override
  _NfcReaderStreamerState createState() => _NfcReaderStreamerState();
}

class _NfcReaderStreamerState extends State<NfcReaderStreamer> {

  bool _supportsNfc=false;
  StreamSubscription<NDEFMessage> _stream;
  bool _reading=false;
  List<NDEFMessage> tags=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    NFC.isNDEFSupported.then((bool isSupported){
      setState(() {
        _supportsNfc=isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Attendence Taker"),
        ),
        body:Builder(builder: (context){
        if(!_supportsNfc){
          return Center(child: Text("Your device does not support nfc"),);
        }
          return tagStreamer();
        },)
      ),
    );
  }

//  Stream<NDEFMessage> getTagMessage(){
//    Stream<NDEFMessage> myStream=NFC.readNDEF();
//    return myStream;
//  }




  Widget startButton(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:Colors.green
      ),
      child: FlatButton(
        child: Text("Start Reading",style:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        onPressed: toggleButton,
      ),
    );
  }

  Widget stopButton(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color:Colors.red
      ),
      child: FlatButton(
        child: Text("Stop reading",style:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        onPressed: toggleButton,
      ),
    );
  }

  Widget tagStreamer(){
    return Column(
      children: [
        Expanded(
          flex: 8,
          child:ListView.builder(itemCount: tags.length,itemBuilder:(context,index){
            return ListView.builder(itemCount:tags.length,itemBuilder: (context,index){
              return ListTile(title: Text("New Student Detected"),);
            });
          }),
        ),
        Expanded(
          child:_reading?stopButton():startButton(),
        )
      ],
    );
  }

  void toggleButton(){
    if (_reading) {
      _stream?.cancel();
      setState(() {
        _reading = false;
      });
    } else {
      setState(() {
        _reading = true;
        // Start reading using NFC.readNDEF()
        _stream = NFC.readNDEF(
          readerMode: NFCDispatchReaderMode(),
          throwOnUserCancel: false,
        ).listen((NDEFMessage message) {
          if(message.isEmpty){
            Flushbar(
              title:  "Empty Tag Detected",
              message:  "Tag is empty",
              duration:  Duration(seconds: 3),
            )..show(context);
          }else{
            Flushbar(
              title:  "Tag detected",
              message:  "Read a tag ${message.payload},tag type:${message.tag},data on the tag:${message.data}",
              duration:  Duration(seconds: 3),
            )..show(context);
            updateList(message);
          }

        }, onError: (e) {
          Flushbar(
            title:  "Error Occurred",
            message:  "${e.toString()}",
            duration:  Duration(seconds: 3),
          )..show(context);
        });
      });
    }
  }

  void updateList(NDEFMessage message){
    NDEFMessage custommessage=new NDEFMessage("Tag", []);
    tags.add(custommessage);
    List<NDEFMessage> temp=tags;
    setState(() {
      tags=temp;
    });
  }
}
