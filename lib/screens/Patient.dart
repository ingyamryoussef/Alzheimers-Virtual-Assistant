import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'api_config.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
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
  Future Upload(token) async{
    List Speakers=[];
    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/upload/' ));
    // request.fields['id']='4';
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(http.MultipartFile.fromBytes("picture", file!.readAsBytesSync(),filename: file!.path.split("/").last));
    var response = await request.send();
    print(response);

    final respStr = await response.stream.bytesToString();
    final jsonData = jsonDecode(respStr) as List;
    setState(() {
      Speakers = jsonData;
    });
    print(response) ;
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(''),
      content: Text(
          Speakers[0]['name'],style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 30 ,fontWeight: FontWeight.bold)
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('CLOSE',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.indigo[900], fontSize: 15))
        )],
    ));
  }
  // List Speakers=[];
  // var request = http.MultipartRequest('POST',Uri.http('192.168.56.1:8001' , 'upload/' ));
  // final prefs = await SharedPreferences.getInstance();
  // final authToken = prefs.getString(token);
  // request.headers['Authorization'] = 'Bearer $authToken';
  // request.headers['Content-Type'] = 'multipart/form-data';
  // request.files.add(http.MultipartFile.fromBytes("picture", file!.readAsBytesSync(),filename: file!.path.split("/").last));
  // var response = await request.send();
  // print(response);
  //
  // final respStr = await response.stream.bytesToString();
  // final jsonData = jsonDecode(respStr) as List;
  // setState(() {
  //    Speakers = jsonData;
  //  });
  // print(response) ;
  // showDialog(context: context, builder: (context) => AlertDialog(
  //   title: Text(''),
  //   content: Text(
  //     Speakers[0]['name'],style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.black, fontSize: 30 ,fontWeight: FontWeight.bold)
  //   ),
  //   actions: [
  //     TextButton(onPressed: (){
  //       Navigator.pop(context);
  //     }, child: Text('CLOSE',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.indigo[900], fontSize: 15))
  //     )],
  // ));

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Color(0xFF0F1D44),
        title: Text('Reminder',
          style:TextStyle(fontFamily: 'Montserrat Medium',
              color: Colors.white,
              fontSize: 30),),
        centerTitle: true,
      ),
      // drawer: Drawer(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              file !=null
                  ?ClipOval(
                child: Image.file(
                  file!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,),
              )
                  :SvgPicture.asset(
                'assets/add.svg',height: 150,),
              SizedBox(height: 50),
              Container(
                child: ElevatedButton.icon(
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
                    label: Text('Camera',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 15))),
              ),
              Container(
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.deepOrange[300];
                          return null;
                        },
                      ),
                    ),
                    onPressed:  (){Upload("token");},

                    icon: Icon(Icons.save),
                    label: Text('Send',style: TextStyle(fontFamily: 'Montserrat Medium', color: Colors.white, fontSize: 15))
                ),
              )],
          ),
        ),
      ),
    );
  }
}
