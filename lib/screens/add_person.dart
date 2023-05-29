import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: add_app(),
//     );
//   }
// }

class add_app extends StatefulWidget {
  @override
  _add_appState createState() => _add_appState();
}

class _add_appState extends State<add_app> {
  final myController = TextEditingController();
  String alert = '';
  final myController1 = TextEditingController();
  File? file;
  Future getImage() async {
// Pick an image
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//TO convert Xfile into file
    setState(() {
      file = File(image!.path);
    });
//print(‘Image picked’);
//     return file!;
  }
  Future<void> Upload(String name, String relationship, String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(token);

      var request = http.MultipartRequest('POST', Uri.http(APIConfig.ipAddress, 'speaker_recognition/caregiverAdd/'));
      request.headers['Authorization'] = 'Bearer $authToken';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['recognized_name'] = name;
      request.fields['relationship'] = relationship;
      request.files.add(http.MultipartFile.fromBytes("picture", file!.readAsBytesSync(), filename: file!.path.split("/").last));

      var response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        print('Text and image sent successfully!');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(''),
            content: Text(
              'Saved successfully!',
              style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.indigo[900], fontSize: 15),
                ),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Please create an email for the patient first.');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Email Validation Error'),
          content: Text(
            'Please create an email for the patient first.',
            style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.indigo[900], fontSize: 15),
              ),
            ),
          ],
        ),
      );
    }
  }



  File? image;
  Future pickImage(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e){
      print('failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // Header with a back button.
      // appBar: AppBar(
      //     backgroundColor: Colors.lightBlue,
      //     title: Text('Add Person'),
      //     centerTitle: true,
      //     leading: IconButton(icon: Icon(Icons.arrow_back),
      //         onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaregiverScreen()))
      //     )),

      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        toolbarHeight: 55,
        title: Text('Add Person',
          style:TextStyle(fontFamily: 'Montserrat Medium',
              color: Colors.white,
              fontSize: 30),),
        centerTitle: true,
        // leading: IconButton(icon: Icon(Icons.arrow_back),
        //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaregiverScreen()))
        // ),
        // flexibleSpace: Container(
        //   height: 150,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage('assets/images/top_header.png'),
        //           fit: BoxFit.fill
        //       )
        //   ),
        // ),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            file !=null
                ?ClipOval(
              child: Image.file(
                file!,
                width: 150,
                height: 57,
                fit: BoxFit.fill,),
            )
                :Image.asset('assets/brain.jpg',height: 57,),
            // Button to access the gallery.
            SizedBox(height: 3),
            // Two text fields for name and description.
            SizedBox(
                width: 350,
                child:TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter name',
                    ))),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child:TextField(
                  controller: myController1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Relationship status',
                    hintText: 'Enter more info',
                  )),
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.deepOrange[300];
                      return null;
                    },
                  ),
                ),
                onPressed: getImage ,
                icon: Icon(Icons.camera_alt),
                label: Text('Gallery',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 15))),

            // SizedBox(height: 15),

            // Button to save info with an icon and text on it.
            ElevatedButton.icon(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                      {
                        return Colors.deepOrange[300];
                      }
                      return Colors.deepOrange[300];
                    },
                  ),
                ),
                onPressed : (){
                  final name = myController.text;
                  final relationship = myController1.text;
                  Upload(name,relationship,"token");
                } ,
                icon : Icon (Icons.save) ,
                label : Text('Save',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 15))) ,

          ],   ),   ), ); } }