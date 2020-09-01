import 'dart:async';

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
          title: Text("Attendence Center"),
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
            return ListTile(title: Text(tags[index].data),);
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
          throwOnUserCancel: false,
        ).listen((NDEFMessage message) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Message data:${message.data},message payload:${message.payload},"),));
          updateList(message);
        }, onError: (e) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString()),));
          return;
        });
      });
    }
  }

  void updateList(NDEFMessage message){
    tags.add(message);
    List<NDEFMessage> temp=tags;
    setState(() {
      tags=temp;
    });
  }
}
