// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:url_launcher/url_launcher.dart';
//import 'dart:ui';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:alzheimer_virtual_assistant_app/classes/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';


class login3 extends StatefulWidget {
  const login3({Key? key}) : super(key: key);

  @override
  State<login3> createState() => _login3State();
}

class _login3State extends State<login3> {
  Gradient g1 = LinearGradient(
    colors: [
      Color(0xFF18B1BD), //blue gradient
      Color(0xFF060FA1),
    ],
  );

  //List<TextEditingController> contList=[];
   final controllerEmail = TextEditingController();
   final controllerPassword = TextEditingController();
   String alert = '';
   bool backendValid = false;
  @override
void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.fromLTRB(30.0,80.0,30.0,20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Image.asset(
                            'assets/logo1.png',
                            height: 100.0,
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0,
                              fontFamily: 'Dosis',
                              fontSize: 45.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Login as a patient',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0,
                              fontFamily: 'Dosis',
                              fontSize: 17.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.white)
                              ),
                              labelText:'Enter your email',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            controller: controllerEmail,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(width: 3, color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Colors.white)
                              ),
                              labelText:'Enter your password',
                              labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            controller: controllerPassword,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                          ),
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
                              heroTag: UniqueKey(),
                            onPressed: () {
                              // loginFunction();
                              final email = controllerEmail.text;
                              final password = controllerPassword.text;
                              Upload(email,password);

                            },
                            label: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            shape: StadiumBorder(),
                            gradient: g1,
                          ),
                          SizedBox(height: 20,),
                          // InkWell(
                          //   onTap: () {
                          //     //Navigator.pushNamed(context, '/home');
                          //     Navigator.pushReplacementNamed(context,'/signup_patient');
                          //   },
                          //   child: Text(
                          //     'Signup',
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       color: Color(0xFF18B1BD),
                          //     ),
                          //   ),
                          //
                          // ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login_caregiver');
                            },
                            child: Text(
                              'Login as a caregiver',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF18B1BD),
                              ),
                            ),

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


  // void loginFunction() async{
  //   backendValid = await accessBackend();
  //   if(controllerEmail.text!='' && controllerPassword.text!='' && controllerEmail.text.contains('@') && backendValid ) {
  //     alert = 'success';
  //     // await Navigator.pushReplacementNamed(context, '/home', arguments: {"name":"Ingy", "email":"${controllerEmail.text}"});
  //
  //     // Person patient = await Person("Ingy", "${controllerEmail.text}");
  //     // await Navigator.pushReplacementNamed(context, '/home', arguments: patient);
  //     await Navigator.pushReplacementNamed(context, '/tutorial',arguments:  '''{"name":"Name" , "email":"${controllerEmail.text}"}''');
  //     // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"Name" , "email":"${controllerEmail.text}"}''' );
  //     setState(() {
  //       controllerEmail.text='';
  //       controllerPassword.text='';
  //       alert='';
  //     });
  //   }
  //   else{
  //     setState(() {
  //       alert='Wrong email or password\ntry again';
  //     });
  //   }
  // }
  //
  // Future<bool> accessBackend() async{
  //   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  //   if (response.statusCode == 200) {
  //     // Data was successfully fetched
  //     final data = response.body;
  //     Map mymap = jsonDecode(data);
  //     print(mymap['title']);
  //     return true;
  //
  //     // Process the data here
  //   } else {
  //     // Request failed
  //     throw Exception('Failed to fetch data');
  //     return false;
  //   }
  // }

  Future Upload(email,password) async{
    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/loginPatient/' ));
    request.fields['email']=email;
    request.fields['password']=password;
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {

      print('email and password sent successfully!');
      final respStr = await response.stream.bytesToString();
      final jsonData = jsonDecode(respStr) as Map<String, dynamic>;
      final access = jsonData['access'];
      // print('Access token: $access');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", access);

      print(prefs.getString("token"));
      // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" }''' );
      await Navigator.pushReplacementNamed(context, '/tutorial',arguments:  '''{"email":"${email}"}''');
      // , arguments:  '''{"name":"${jsonData['patient_name']}"}''' );
      // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" , "email":"${controllerEmail.text}"}''' );
    } else{
      setState(() {
        alert='Wrong email or password\ntry again';
      });
    }}

}

