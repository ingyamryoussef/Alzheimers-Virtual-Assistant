// import 'package:flutter/material.dart';
//
// class SignupWidget extends StatefulWidget {
//   @override
//   _SignupWidgetState createState() => _SignupWidgetState();
// }
//
// class _SignupWidgetState extends State<SignupWidget> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign up'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                 ),
//                 // validator: (value) {
//                 //   if (value.isEmpty) {
//                 //     return 'Please enter your username';
//                 //   }
//                 //   return null;
//                 // },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 // validator: (value) {
//                 //   if (value.isEmpty) {
//                 //     return 'Please enter your email address';
//                 //   }
//                 //   if (!value.contains('@')) {
//                 //     return 'Please enter a valid email address';
//                 //   }
//                 //   return null;
//                 // },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 obscureText: true,
//                 // validator: (value) {
//                 //   if (value.isEmpty) {
//                 //     return 'Please enter your password';
//                 //   }
//                 //   if (value.length < 6) {
//                 //     return 'Your password must be at least 6 characters long';
//                 //   }
//                 //   return null;
//                 // },
//               ),
//               SizedBox(height: 32.0),
//               FloatingActionButton(
//                 onPressed: () {
//                   // if (_formKey.currentState.validate()) {
//                   //   // TODO: Call your sign-up API here
//                   // }
//                 },
//                 child: Text('Sign up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:url_launcher/url_launcher.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alzheimer_virtual_assistant_app/public_variables.dart';

import 'api_config.dart';


class signup_caregiver extends StatefulWidget {
  const signup_caregiver({Key? key}) : super(key: key);

  @override
  State<signup_caregiver> createState() => _signup_caregiverState();
}

class _signup_caregiverState extends State<signup_caregiver> {
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
  String ip_port = ip_and_portnum;
  int userid = 0;
  String useremail = "";
  String userfirstname = "";
  String gender='male';
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
                            'Create a Caregiver Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0,
                              fontFamily: 'Dosis',
                              fontSize: 17.0,
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
                              final email = controllerEmail.text;
                              final password = controllerPassword.text;
                              final first_name=controllerFirstName.text;
                              final last_name=controllerLastName.text;
                              Upload(email,password,first_name,last_name);
                            },
                            label: Text(
                              "Signup",
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
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'Already have an accont? Login',
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
      await Navigator.pushReplacementNamed(context, '/caregiver_home', arguments: '''{"name":"$userfirstname" , "email":"$useremail" , "id":"$userid"}''');
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
    final url = 'http://${APIConfig.ipAddress}/speaker_recognition/main/caregivers/';
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

  Future Upload(email,password,first_name,last_name) async{

    // Check the response status code
    if(controllerFirstName.text=='' || controllerLastName.text=='')
    {
      setState(() {
        alert='Enter a valid name';
      });
    }
    else if(controllerEmail.text=='' || !controllerEmail.text.contains('@'))
    {
      setState(() {
        alert='Enter a valid Email';
      });
    }
    else if(controllerPassword.text=='' || controllerPassword.text.length<6)
    {
      setState(() {
        alert='Password should be\n6 characters or more';
      });
    }
    else if(controllerConfirmPassword.text!=controllerPassword.text)
    {
      setState(() {
        alert='Wrong Password\nconfirmation';
      });
    }
    else {
      var request = http.MultipartRequest('POST',Uri.http(APIConfig.ipAddress , 'speaker_recognition/caregivers/signup/' ));
      request.fields['email']=email;
      request.fields['password']=password;
      request.fields['first_name']=first_name;
      request.fields['last_name']=last_name;
      var response = await request.send();
        if (response.statusCode == 201 || response.statusCode == 200) {
          await Navigator.pushReplacementNamed(context, '/caregiver_home', arguments:'''{ "email":"$email"}''');
          setState(() {
            alert='Created successfulyy';
          });

          //await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"${jsonData['patient_name']}","email":"${email}"}''' );
          // await Navigator.pushReplacementNamed(context, '/home', arguments:  '''{"name":"ingy" , "email":"${controllerEmail.text}"}''' );
        } else{
          setState(() {
            alert='Email already exists\ntry again';
          });
        }

    }
  }
}

