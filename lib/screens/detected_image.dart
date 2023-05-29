import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';
import 'facee.dart';

class DetectedImage extends StatefulWidget {
  const DetectedImage({Key? key}) : super(key: key);

  @override
  State<DetectedImage> createState() => _DetectedImageState();
}

class _DetectedImageState extends State<DetectedImage> {
  InputImage? imagee;
  String? fileImage;
  String? userEmail;
  File? filee;
  String? speakerName;
  String? speakerRelationship;
  int? speakerID;
  int? speaker_ID=1;
  String summary="No conversations yet";



  @override
  void initState() {
    assignVariables();
    super.initState();
    Upload("token");
  }
  Future Upload(token) async{
    List Speakers=[];
    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/upload/' ));
    // request.fields['id']='4';

    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(http.MultipartFile.fromBytes("picture", filee!.readAsBytesSync(),filename: filee!.path.split("/").last));
    var response = await request.send();
    print(response);

    final respStr = await response.stream.bytesToString();
    final jsonData = jsonDecode(respStr) as List;
    setState(() {
      Speakers = jsonData;
    });
    setState(() {
      speakerName= Speakers[0]['name'];
      speakerRelationship=Speakers[0]['relationship'];
      speakerID=Speakers[0]['id'];
      get_last_conversation(speakerID);


      print(Speakers[0]);
    });
    print(response) ;
  }
  Future Upload2(token,String name) async{
    List Speakers=[];
    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/patientAddNewSpeaker/'));
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['recognized_name'] = name;
    request.files.add(http.MultipartFile.fromBytes("picture", filee!.readAsBytesSync(),filename: filee!.path.split("/").last));
    var response = await request.send();
    print(response);
    final respStr = await response.stream.bytesToString();
    final jsonData = jsonDecode(respStr) as List;
    setState(() {
      Speakers = jsonData;
    });
    setState(() {
      speakerID=Speakers[0]['id'];
      print('speaker id is $speakerID');

    });
    return speakerID;
  }
  Future assignVariables() async{

    fileImage = Get.arguments['file'] ;
    filee = File(fileImage!);
    print(fileImage);

    userEmail=Get.arguments['email'];

    setState(() {});
  }
  Future get_last_conversation(myspeakerid) async {
    // final url = Uri.parse('http://${APIConfig.ipAddress}/conversation_analysis/last_speaker_conversation/');
    final response = await http.get(Uri.parse('http://${APIConfig.ipAddress}/conversation_analysis/last_conversation/?email=$userEmail&speaker_id=$myspeakerid'));
    // final request = http.MultipartRequest('POST', url);
    // request.fields["email"]=userEmail!;
    // request.fields["speaker_id"]=speakerID as String;
    // final response = await request.send();
    final data = response.body;
    Map mymap = jsonDecode(data);
    print(mymap);
    summary= await mymap["summarized_text"];
    setState(() {

    });
    // return summary;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: (){
          Navigator.pushReplacementNamed(context, '/home',arguments: '''{"email":"$userEmail"}''');
        }),
        title: Text("Face is detected"),
      ),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 70),
              Container(
                height: 300,
                width: 300,
                child:filee==null? CircularProgressIndicator():
                CircleAvatar(
                  backgroundImage: FileImage(filee!),
                  radius: 20,
                ),
              ),
              SizedBox(height: 20),
              speakerName==null? Padding(
                padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:20.0),
                child: SizedBox(height: 200,child: SingleChildScrollView(child: Text("Loading ...",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))),
              ):Padding(
                padding: const EdgeInsets.symmetric(vertical:0.0,horizontal:20.0),
                child: SizedBox(height: 200,child: SingleChildScrollView(child: Text("Name: $speakerName\nRelationship:$speakerRelationship\nLast Conversation Summary:$summary",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),))),
              ), //
              SizedBox(height: 10,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60),
                  backgroundColor: Colors.blue,
                ) ,
                //child: child,
                icon: Icon(Icons.navigate_next),
                label: Text(
                  "Record Conversation",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, fontFamily: 'Dosis'),
                ),
                onPressed:() async {
                  if ('$speakerName' == 'Unknown') {
                    speakerID = await Upload2("token", 'Unknown');
                  }

                  print('speaker id --> $speakerID');
                  Navigator.pushNamed(context, '/speech_rec', arguments: '''{"email":"$userEmail","speaker_id":$speakerID}''');
                },
              ),

            ],
          )
      ),
    );
  }


}
