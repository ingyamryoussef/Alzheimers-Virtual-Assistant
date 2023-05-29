import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:ui';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alzheimer_virtual_assistant_app/public_variables.dart';

import 'api_config.dart';

class create_patient extends StatefulWidget {
  const create_patient({Key? key}) : super(key: key);

  @override
  State<create_patient> createState() => _create_patientState();
}

class _create_patientState extends State<create_patient> {
  Gradient g1 = LinearGradient(
    colors: [
      Color(0xFF18B1BD), //blue gradient
      Color(0xFF060FA1),
      // Color(0xff0e6f9d), //blue gradient 2
      // Color(0xff062f42),
      // Color(0xFF309F93), //green gradient
      // Color(0xFF19524C),
    ],
  );
  Future Upload(email,password,first_name,last_name,token) async{

    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/caregiverpatient/signup/' ));
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(token);
    request.headers['Authorization'] = 'Bearer $authToken';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['email']=email;
    request.fields['password']=password;
    request.fields['first_name']=first_name;
    request.fields['last_name']=last_name;
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 201) {
      Navigator.pop(context);
      setState(() {
        alert='Created successfulyy';
      });

      //await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"${jsonData['patient_name']}","email":"${email}"}''' );
      // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" , "email":"${controllerEmail.text}"}''' );
    }else if(response.statusCode==403) {
      setState(() {
        alert='You can only create one account per patient';
      });
    }
    else{
      setState(() {
        alert='Wrong email or password\ntry again';
      });
    }
  }
  String ip_port = ip_and_portnum;
  int userid = 0;
  String useremail = "";
  String userfirstname = "";
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  String alert = '';
  bool backendValid = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:
        AppBar(
          backgroundColor: Color(0xFF0F1D44),

        ),
        //backgroundColor: Colors.blue,

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background4.PNG'),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget> [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Image.asset(
                            'assets/logo1.png',
                            height: 50.0,
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0,
                              fontFamily: 'Dosis',
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Create a Patient Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0,
                              fontFamily: 'Dosis',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: SignupInputDecoration('First name *'),
                            style: TextStyle(color: Colors.white),
                            controller: controllerFirstName,
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            decoration: SignupInputDecoration('Last name *'),
                            style: TextStyle(color: Colors.white),
                            controller: controllerLastName,
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            decoration: SignupInputDecoration('Email *'),
                            style: TextStyle(color: Colors.white),
                            controller: controllerEmail,
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            decoration: SignupInputDecoration('Password (6 or more characters) *'),
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            controller: controllerPassword,
                          ),
                          SizedBox(height: 30.0,),
                          TextFormField(
                            decoration: SignupInputDecoration('Confirm your password *'),
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            controller: controllerConfirmPassword,
                          ),
                          // SizedBox(height: 30.0,),
                          // Row(
                          //   children: [
                          //     Radio(
                          //       //title: Text("Male", style: GenderStyle(),),
                          //       value: "male",
                          //       groupValue: gender,
                          //       fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          //       onChanged: (value){
                          //         setState(() {
                          //           gender = value.toString();
                          //         });
                          //       },
                          //     ),
                          //     Text("Male", style: GenderStyle(),),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Radio(
                          //       //title: Text("Female", style: GenderStyle(),),
                          //       value: "female",
                          //       groupValue: gender,
                          //       fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          //       onChanged: (value){
                          //         setState(() {
                          //           gender = value.toString();
                          //         });
                          //       },
                          //     ),
                          //     Text("Female", style: GenderStyle(),)
                          //   ],
                          // ),
                          SizedBox(height: 10.0),
                          Text(
                            '$alert',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20
                            ),
                          ),
                          SizedBox(height: 15.0),
                          a.GradientFloatingActionButton.extended(
                            onPressed: () {
                              // signupFunction();
                              final email = controllerEmail.text;
                              final password = controllerPassword.text;
                              final first_name=controllerFirstName.text;
                              final last_name=controllerLastName.text;
                              Upload(email,password,first_name,last_name,"token");
                            },
                            label: Text(
                              "Create",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            shape: StadiumBorder(),
                            gradient: g1,
                          ),

                          SizedBox(height: 30.0),

                        ],
                      ),
                    ),

                  ]
              ),
            ),
          ),
        )
    );
  }
  TextStyle GenderStyle(){
    return TextStyle(
        color: Colors.white,
        fontSize: 20
    );
  }
  InputDecoration SignupInputDecoration(String labletext){
    return InputDecoration(
      enabledBorder: OutlineInputBorder
        (
        borderSide: BorderSide(width: 2, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder:  OutlineInputBorder
        (
        borderSide: BorderSide(width: 3, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      labelText:'$labletext',
      labelStyle: TextStyle(color: Color(0xFFCBCBCB), fontSize: 20.0),
    );
  }
  void signupFunction() async{
    backendValid = await accessBackend(controllerFirstName.text,controllerLastName.text,controllerEmail.text,controllerPassword.text);
    if(controllerFirstName.text!='' && controllerLastName.text!='' && controllerEmail.text!='' && controllerPassword.text!='' && controllerConfirmPassword.text!='' && controllerEmail.text.contains('@') && controllerPassword.text.length>=6 && controllerConfirmPassword.text==controllerPassword.text && backendValid ) {
      alert = 'success';
      await Navigator.of(context).pop;
      setState(() {
        controllerFirstName.text='';
        controllerLastName.text='';
        controllerEmail.text='';
        controllerPassword.text='';
        controllerConfirmPassword.text='';
        alert='';
      });
    }
    else if(!controllerEmail.text.contains('@')){
      setState(() {
        alert='Enter a valid email';
      });
    }
    else if(controllerPassword.text.length<6){
      setState(() {
        alert='Enter Password of 6 characters\nor more';
      });
    }
    else if(controllerPassword.text!=controllerConfirmPassword.text){
      setState(() {
        alert='Confirm password correctly';
      });
    }
    else if(!backendValid){
      setState(() {
        alert='This account already exists\ntry again';
      });
    }
    else {
      setState(() {
        alert='Fill all the requirements';
      });
    }
  }

  Future<bool> accessBackend(first,last,email,pass) async {
    final url = 'http://${APIConfig.ipAddress}/speaker_recognition/main/patients/';

    final response = await http.post(
        Uri.parse(url),
        body: {
          "first_name": "$first",
          "last_name": "$last",
          "email": "$email",
          "password": "$pass",
        });
    final responseData = json.decode(response.body);
    userid = responseData["id"];
    useremail = responseData["email"];
    userfirstname = responseData["first_name"];
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(responseData);
      return true;
    } else {
      print("backend ERROR");
      return false;
    }
  }

}

