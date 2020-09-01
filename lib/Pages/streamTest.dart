import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class StreamSubTest extends StatefulWidget {
  @override
  _StreamSubTestState createState() => _StreamSubTestState();
}

class _StreamSubTestState extends State<StreamSubTest> {
  bool _supportsNfc=false;
  StreamSubscription<int> _stream;
  bool _reading=false;
  List<int> tags=[];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();

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
            return ListTile(title: Text(tags[index].toString()),);
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
        _stream = mockStream().listen((int data) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Data read:${data}"),));
          updateList(data);
        }, onError: (e) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString()),));
          return;
        });
      });
    }
  }

  void updateList(int message){
    tags.add(message);
    List<int> temp=tags;
    setState(() {
      tags=temp;
    });
  }





  Stream<int> mockStream() {
    final duration = Duration(seconds: 2);
    Stream<int> myStream = Stream.periodic(duration, (value) {
      return (value + 1) * 2;
    });

    myStream=myStream.take(5);
    return myStream;
  }
}
