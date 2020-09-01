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
        appBar: AppBar(
          title:Text("Attendence Reader"),
        ),
        body: Builder(builder: (context){
          if(!_supportsNfc){
            return Scaffold(
              body: Center(
                child: RaisedButton(
                  child: const Text("You device does not support NFC"),
                  onPressed: null,
                ),
              ),
            );
          }
          return RaisedButton(
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
                      showDialog(context: context,builder: (context){
                        return AlertDialog(
                          title: Text("Tag details"),
                          content: Text("Tag details:${message.payload}"),
                          actions: [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                    }, onError: (e) {
                      // Check error handling guide below
                    });
                  });
                }
              }
          );
        },),
      ),
    );

  }
}
