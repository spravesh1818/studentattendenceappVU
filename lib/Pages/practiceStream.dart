import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

class NfcReaderStreamer extends StatefulWidget {
  @override
  _NfcReaderStreamerState createState() => _NfcReaderStreamerState();
}

class _NfcReaderStreamerState extends State<NfcReaderStreamer> {

  Stream<int> _stream;
  bool _supportsNfc=false;

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
          title: Text("Attendence Center"),
        ),
        body:Builder(builder: (context){
        if(!_supportsNfc){
          return Center(child: Text("Your device does not support nfc"),);
        }
          return streamer();
        },)
      ),
    );
  }

  Stream<NDEFMessage> getTagMessage(){
    Stream<NDEFMessage> myStream=NFC.readNDEF();
    return myStream;
  }



  Widget streamer(){
    return StreamBuilder(
        stream: getTagMessage(),
        builder:(context,snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Some error occurred"),);
          }
          if(snapshot.hasData){
            return tagStreamer(snapshot);
          }
          return Center(child:CircularProgressIndicator() ,);
        }
    );
  }



  Widget startButton(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:Colors.green
      ),
      child: FlatButton(
        child: Text("Please tap a card here to attend",style:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        onPressed: (){
        },
      ),
    );
  }

  Widget tagStreamer(AsyncSnapshot<NDEFMessage> snapshot){
    return Column(
      children: [
        Expanded(
          flex: 8,
          child:ListTile(title: Text("Data on the card ${snapshot.data.payload}")),
        ),
        Expanded(
          child:startButton(),
        )
      ],
    );
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
