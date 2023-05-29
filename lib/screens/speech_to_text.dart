import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class speech_recognition extends StatefulWidget {
  const speech_recognition({Key? key}) : super(key: key);

  @override
  State<speech_recognition> createState() => _speech_recognitionState();
}

class _speech_recognitionState extends State<speech_recognition> {
  late stt.SpeechToText _speechToText;
  bool isListening = false;
  bool flag = false;
  String _text = "Conversation starting ...";
  String _tempText = "";
  double confidence = 1.0;
  Duration _duration = new Duration(seconds: 20);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speechToText=stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listenFunction,
          child: Icon(isListening ? Icons.mic : Icons.mic_none , color: Colors.white,),
          backgroundColor: Colors.blue[900],

        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            '$_text',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Dosis'
            ),
          ),
        ),
      ),
    );
  }

  void _listenFunction() async {

    if(!isListening) {

      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        setState(() => isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
              setState(() => isListening = false);
            }
          }),
        );

        // setState(() => isListening = false);
        // _speechToText.stop();
      }
    } else {
      setState(() => isListening = false);
      //flag = false;
      _speechToText.stop();
    }
    }
  // void _listenFunction() async {
  //   //_tempText = "";
  //   await () {flag=!flag;};
  //
  //   while (flag) {
  //     print("Entered loop");
  //     setState(() => isListening = true);
  //     available = await _speechToText.initialize(
  //     onStatus: (val) => print('onStatus: $val'),
  //     onError: (val) => print('onError: $val'),
  //     );
  //
  //     if(available){
  //
  //       await _speechToText.listen(
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords;
  //           // if (val.hasConfidenceRating && val.confidence > 0) {
  //           //   confidence = val.confidence;
  //           // }
  //         }),
  //       );
  //       _speechToText.stop();
  //     }
  //
  //   }
  //
  //   if(!flag) {
  //     setState(() => isListening = false);
  //     _speechToText.stop();
  //   }
  // }


  // void _listenFunction() async {
  // print('function started');
  // flag=!flag;
  //
  // for(int i =1;i<=3;i++){
  //   print('iteration: $i');
  // stt.SpeechToText _speechToText = stt.SpeechToText();
  //   if (flag) {
  //       print('if flag started');
  //
  //       bool available = await _speechToText.initialize(
  //         onStatus: (val) => print('onStatus: $val'),
  //         onError: (val) => print('onError: $val'),
  //       );
  //
  //
  //         if (available) {
  //           setState(() => isListening = true);
  //
  //           _speechToText.listen(
  //             onResult: (val) => setState(() {
  //               //print('first record started');
  //               _text = val.recognizedWords;
  //               if (val.hasConfidenceRating && val.confidence > 0) {
  //                 confidence = val.confidence;
  //               }
  //             }),
  //           );
  //
  //         }
  //     // new Future.delayed(const Duration(seconds: 15), (){
  //     //   setState(() => isListening = false);
  //     //   _speechToText.stop();
  //     // } );
  //
  //   }
  // }
  //   if(!flag) {
  //     setState(() => isListening = false);
  //     //_speechToText.stop();
  //   }
  //
  //
  // }

  // void _listenFunction() {
  //
  // }

}

