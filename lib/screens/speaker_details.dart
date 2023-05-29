import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Speakers.dart';
import 'api_config.dart';

class SpeakerDetails extends StatefulWidget {

  const SpeakerDetails({Key? key}) : super(key: key);

  @override
  State<SpeakerDetails> createState() => _SpeakerDetailsState();
}

class _SpeakerDetailsState extends State<SpeakerDetails> {

  // final myController = TextEditingController();
  // final myController1 = TextEditingController();

  int? speakerId = Get.arguments['id'];
  String? speakerImage = Get.arguments['picture'];
  String? speakerName = Get.arguments['speakerName'];
  String? speakerRelationship = Get.arguments['speakerRelationship'];

  String? newName;
  String? newRelationShip;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState> ();

  // Confirm() async {
  //   var formData = _formKey.currentState;
  //   if(formData!.validate()){
  //     formData.save();
  //     print(newName);
  //     print(newRelationShip);
  //     print("Valid");
  //     if(newName==speakerName && newRelationShip==speakerRelationship){
  //       Get.back();
  //     }
  //   else{
  //     print('Not valid');
  //   }
  // }

  Future Edit(token) async{
    var formData = _formKey.currentState;
    formData!.save();
    var request = http.MultipartRequest('PUT',Uri.http(APIConfig.ipAddress, 'speaker_recognition/edit_speakers/${speakerId}/' ));
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['recognized_name']=newName!;
    request.fields['relationship']=newRelationShip!;
    var response = await request.send();
    // Check the response status code
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => speaker()),
      );
      print('Updated!');
    } else {
      print('Error');
    }
  }
  void Delete(token) async{
    var request = http.Request('DELETE',Uri.http(APIConfig.ipAddress , 'speaker_recognition/delete_speaker/${speakerId}/' ));
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    var response = await request.send();
    // Check the response status code
    if (response.statusCode == 204) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => speaker()),
      );
      print('Updated!');
    } else {
      print('Error');
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar(){
    return AppBar(
      title: Text('Speaker Details',
        style:TextStyle(fontFamily: 'Montserrat Medium',
            color: Colors.white,
            fontSize: 30),),
      centerTitle: true,
      backgroundColor: Colors.indigo[900],
    );
  }
  _body(){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50,),
          Container(
              margin: EdgeInsets.only(bottom: 50),
              height: 250,
              width: 300,
              child: CircleAvatar(
                backgroundImage: NetworkImage(speakerImage!),
                radius: 20,
              )
          ),
          Text("$speakerName",style:TextStyle(fontFamily: 'Montserrat Medium',
              color: Colors.black,
              fontSize: 30,fontWeight: FontWeight.bold),),
          Text("$speakerRelationship",style:TextStyle(fontFamily: 'Montserrat Medium',
              color: Colors.black,
              fontSize: 30),),
          SizedBox(height: 80,),
          Container(
            width: 175,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],

                ),
                onPressed: (){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text('Edit Speaker Details',style: TextStyle(color: Colors.blue[900],fontSize: 23),),
                      content: Container(
                        width: 300,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              TextFormField(
                                // controller: myController,
                                initialValue: speakerName,
                                validator: (text){
                                  if(text!.isEmpty){
                                    return "Name is Empty";
                                  }
                                  return null;
                                },
                                onSaved: (text){
                                  newName=text;
                                },
                                cursorColor: Colors.blue[900],

                                maxLength: 20,
                                decoration: InputDecoration(
                                    hintText: "Enter name",
                                    icon: Icon(Icons.account_circle_outlined),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[900]!
                                        )
                                    )
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("RelationShip:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              TextFormField(
                                // controller: myController1,
                                initialValue: speakerRelationship,
                                validator: (text){
                                  if(text!.isEmpty){
                                    return "RelationShip is Empty";
                                  }
                                  return null;
                                },
                                onSaved: (text){
                                  newRelationShip=text;
                                },
                                cursorColor: Colors.blue[900],
                                maxLength: 20,
                                decoration: InputDecoration(
                                    hintText: "Enter RelationShip",
                                    icon: Icon(Icons.connect_without_contact_outlined),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[900]!
                                        )
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        Container(height: 28,width: 90,child: ElevatedButton(
                            onPressed: (){
                              // final name = myController.text;
                              // final relationship = myController1.text;
                              Edit("token");
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]), child: Text('Confirm'))),
                        Container(height: 28,width: 90,child: ElevatedButton(onPressed: (){Get.back();},style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]), child: Text('Cancel'))),
                      ],
                    );
                  });
                },
                child: Text("Edit",style:TextStyle(fontFamily: 'Montserrat Medium',
                    color: Colors.white,
                    fontSize: 20),)),
          ),
          Container(
            width: 175,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],

                ),
                onPressed: (){Delete("token");},
                child: Text("Delete",style:TextStyle(fontFamily: 'Montserrat Medium',
                    color: Colors.white,
                    fontSize: 20),)),
          ),
        ],
      ),
    );
  }
}