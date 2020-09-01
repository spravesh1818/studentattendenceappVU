import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NfcReaderImple extends StatefulWidget {
  @override
  _NfcReaderImpleState createState() => _NfcReaderImpleState();
}

class _NfcReaderImpleState extends State<NfcReaderImple> {
  bool _supportsNfc=false;
  bool _reading=false;
  StreamSubscription<NDEFMessage> _stream;
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
          title:Text("Attendence Reader"),
        ),
        body: Builder(builder: (context){
          if(!_supportsNfc){
            return Scaffold(
              body: Center(
                child: Text("You device does not support NFC"),
                ),

            );
          }
          return Column(
            children: [

              RaisedButton(
                  child: Text(_reading ? "Stop reading" : "Start reading"),
                  onPressed: () {
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
                          tags.add(message);
                        }, onError: (e) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e.toString()),));
                          // Check error handling guide below
                        });
                      });
                    }
                  }
              ),
              ListView.builder(itemCount:tags.length,itemBuilder: (context,index){
                return ListTile(title: Text(tags[index].data),);
              })
            ],
          );
        },),
      ),
    );

  }
}
