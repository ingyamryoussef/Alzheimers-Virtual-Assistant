//import 'dart:html';


import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:alzheimer_virtual_assistant_app/public_variables.dart';

import 'api_config.dart';


// import 'package:flutter_sound_lite/public/tau.dart';
// import 'package:flutter_sound_lite/public/ui/recorder_playback_controller.dart';
// import 'package:flutter_sound_lite/public/ui/sound_player_ui.dart';
// import 'package:flutter_sound_lite/public/ui/sound_recorder_ui.dart';
// import 'package:flutter_sound_lite/public/util/enum_helper.dart';
// import 'package:flutter_sound_lite/public/util/flutter_sound_ffmpeg.dart';
// import 'package:flutter_sound_lite/public/util/flutter_sound_helper.dart';
// import 'package:flutter_sound_lite/public/util/temp_file_system.dart';
// import 'package:flutter_sound_lite/public/util/wave_header.dart';
//import 'package:google_speech/google_speech.dart';

final pathToSaveAudio = 'audio_myexample.mp3';
final ip_port=ip_and_portnum;
//D:\Gradaution Project\flutter trials\Alzheimer_Virtual_Assistant_App\audio_example.aac

class sample_record extends StatefulWidget {
  const sample_record({Key? key}) : super(key: key);
  @override
  State<sample_record> createState() => _sample_recordState();
}

class _sample_recordState extends State<sample_record> {

  final recorder = SoundRecorder();
  final player = SoundPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recorder.init();
    player.init();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    recorder.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final Object? args = ModalRoute.of(context)?.settings.arguments;
    String myargs = args.toString();
    Map<String, dynamic> samplerecordmap = jsonDecode(myargs);

    return Scaffold(
      appBar: AppBar(
        title: Text('Record Your Voice', style: TextStyle(fontSize:25),),
        centerTitle: true,
        toolbarHeight: 80.0,
        backgroundColor: Color(0xFF0F1D44),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 300.0),
            InkWell(
              onTap:(){
                Navigator.pushReplacementNamed(context, '/home', arguments:'''{"email":"${samplerecordmap["email"]}"}''' );
                // Navigator.pop(context);
                },
              child:SizedBox(
                height: 50,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.blue[900],
                        letterSpacing: 2.0,
                        fontFamily: 'Dosis',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),),
                    Icon(Icons.skip_next, color: Colors.blue[900],),
                  ],
                ),
              ) ,

            ),
            Image.asset(
              'assets/tutorial_pics/sampleaudio.png',
              height: 150.0,
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 170,
              width: 350,
              child: SingleChildScrollView(
                child: Text(
                  'For better results, we need to listen to your voice. \nPress \'Start\', then tell us your name, age and what do you like to do in your day. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF070F25),
                  ),
                ),
              ),
            ),
            buildStart(),
            SizedBox(height: 10.0),
            // buildPlay(),
            // SizedBox(height: 80.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60),
                backgroundColor: Colors.blue,
              ) ,
              //child: child,
              icon: Icon(Icons.navigate_next),
              label: Text(
                "Done",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, fontFamily: 'Dosis'),
              ),
              onPressed:() async{
                recorder.email= await samplerecordmap["email"];
                recorder._uploadVoiceFile();
                // Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home', arguments:'''{"email":"${samplerecordmap["email"]}"}''' );

                setState(() {});
              },
            )
          ],
        ),
      ),
      //   Column(
      //   child: buildStart(),
      // ),
    );
  }
  Widget buildStart(){
    final isRecording = recorder.isRecording;
    final myicon = isRecording ? Icons.stop : Icons.mic;
    final myText = isRecording ? 'Stop' : 'Start';

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 60),
        backgroundColor: Colors.blue,
      ) ,
      //child: child,
      icon: Icon(myicon),
      label: Text(
        myText,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, fontFamily: 'Dosis'),
      ),
      onPressed:() async{
        final isRecording = await recorder.toggleRecording();
        //await recorder.toggleRecording();
        setState(() {});
      },
    );
  }

  Widget buildPlay() {

    final isPlaying = player.isPlaying;
    final myicon = isPlaying ? Icons.stop : Icons.play_arrow;
    final myText = isPlaying ? 'Stop Playing' : 'Play Audio';


    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 60),
        backgroundColor: Colors.blue,
      ) ,
      //child: child,
      icon: Icon(myicon),
      label: Text(
        myText,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, fontFamily: 'Dosis'),
      ),
      onPressed:() async{
        await player.togglePlaying(whenFinished: () => setState(() {}));
        setState(() {});
      },
    );
  }
  // Widget buildPause() {
  //
  // }
  // Widget buildDone() {
  //   return ElevatedButton.icon(
  //     style: ElevatedButton.styleFrom(
  //       minimumSize: Size(200, 60),
  //       backgroundColor: Colors.blue,
  //     ) ,
  //     //child: child,
  //     icon: Icon(Icons.navigate_next),
  //     label: Text(
  //       "Done",
  //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, fontFamily: 'Dosis'),
  //     ),
  //     onPressed:() async{
  //
  //       recorder._uploadVoiceFile();
  //       Navigator.pushReplacementNamed(context, '/home');
  //       setState(() {});
  //     },
  //   );
  // }

}



class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordingInitialised = false;
  bool get isRecording => _audioRecorder!.isRecording;
  String filePath="";
  String email="";
  bool sentflag=false;
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException('Microphone Permission not allowed');
    }
    await _audioRecorder!.openAudioSession();
    _isRecordingInitialised = true;
  }
  void dispose(){
    if(!_isRecordingInitialised) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecordingInitialised = false;
  }

  Future<void> _uploadVoiceFile() async {
    print("Upload function called");
    if(filePath!=""){
      final url = Uri.parse('http://${APIConfig.ipAddress}/conversation_analysis/patient_audio_upload/');
      final request = http.MultipartRequest('POST', url);
      request.fields["email"]=email;
      request.files.add(await http.MultipartFile.fromPath('audio_file', filePath));
      final response = await request.send();
      // final responseData = json.decode(response.stream.bytesToString(utf8));
      sentflag=true;
      print('Voice file uploaded successfully, response: $response');
      //setState(() { _isUploading = false; });
    }
    else{
      print("nothing was recorded");
    }
  }

  Future _record() async {
    if(!_isRecordingInitialised) return;
    try{
      await _audioRecorder!.startRecorder(toFile: 'audio_example.aac');
    }
    catch(e){ print('error: $e');}
    print('RECORDING STARTED');
  }
  Future _stop() async {
    if(!_isRecordingInitialised) return;
    await _audioRecorder!.stopRecorder().then((value) {
      filePath = '$value';
      print('the path of you file is: $filePath');
      // _uploadVoiceFile('$value');
    });
    print('RECORDING STOPPED');

  }
  Future toggleRecording() async {
    print('RECORDING TOGGLED');
    if(_audioRecorder!.isStopped) {
      await _record();
    }
    else {
      await _stop();

    }
  }
}

class SoundPlayer {

  FlutterSoundPlayer? _audioPlayer;
  bool get isPlaying => _audioPlayer!.isPlaying;

  // Future<List<int>> _getAudioContent(String name) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path + '/$name';
  //   return File(path).readAsBytesSync().toList();
  // }

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openAudioSession();
  }

  void dispose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!.startPlayer(
      fromURI: 'audio_example.aac',
      whenFinished: whenFinished,
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if(_audioPlayer!.isStopped){
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }



}