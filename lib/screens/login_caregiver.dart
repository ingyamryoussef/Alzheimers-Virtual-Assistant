import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'dart:ui';
import 'package:drop_shadow/drop_shadow.dart';

import 'api_config.dart';


class login_caregiver extends StatefulWidget {
  const login_caregiver({Key? key}) : super(key: key);

  @override
  State<login_caregiver> createState() => _login_caregiverState();
}

class _login_caregiverState extends State<login_caregiver> {
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
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  //List<TextEditingController> contList=[];
  String alert = '';
  bool backendValid = true;
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
                            'Login as a caregiver',
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
                          SizedBox(height: 20.0),
                          a.GradientFloatingActionButton.extended(
                            heroTag: UniqueKey(),
                            onPressed: () {
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
                          InkWell(
                            onTap: () {
                              //Navigator.pushNamed(context, '/home');
                              Navigator.pushReplacementNamed(context,'/signup_caregiver');
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF18B1BD),
                              ),
                            ),

                          ),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'Login as a patient',
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


  void loginFunction() async{
    print('email is ${controllerEmail.text} and password is ${controllerPassword.text}');
    if(controllerEmail.text!='' && controllerPassword.text!='' && controllerEmail.text.contains('@') && backendValid ) {
      alert = await accessDB();
      Navigator.pushReplacementNamed(context, '/caregiver_home');
      setState(() {
        controllerEmail.text='';
        controllerPassword.text='';
        alert='';
      });
    }
    else{
      setState(() {
        alert='Wrong email or password \ntry again';
      });
    }
  }
  String accessDB(){
    print('database accessed');
    return 'success';
  }


  Future Upload(email,password) async{
    print('adam');
    var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress, 'speaker_recognition/loginCaregiver/' ));
    request.fields['email']=email;
    request.fields['password']=password;
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200 || response.statusCode == 201) {

      print('email and password sent successfully!');
      final respStr = await response.stream.bytesToString();
      final jsonData = jsonDecode(respStr) as Map<String, dynamic>;
      final access = jsonData['access'];
      // print('Access token: $access');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", access);
      print(prefs.getString("token"));
      // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" }''' );
      await Navigator.pushReplacementNamed(context, '/caregiver_home',arguments:'''{ "email":"$email"}''');
      // arguments:  '''{"name":"${jsonData['caregiver_name']}","email":"${email}"}''' );
      // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" , "email":"${controllerEmail.text}"}''' );
    } else{
      setState(() {
        alert='Wrong email or password\ntry again';
      });
    }}

}

