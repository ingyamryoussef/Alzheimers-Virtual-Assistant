// import 'dart:html';
// import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({Key? key}) : super(key: key);

  @override
  State<CaregiverScreen> createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  @override
  String homeemail="";
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    String myargs = args.toString();
    Map<String, dynamic> homemap = jsonDecode(myargs);
    homeemail = homemap["email"];
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Medium",
        fontSize: 16,
        color: Color.fromRGBO( 255, 255, 255, 1.0));

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
          decoration: BoxDecoration(
            color: Color(0xFF0A122C),
            // image: DecorationImage(
            //   image: AssetImage('assets/background4.PNG'),
            //   fit: BoxFit.cover,
            // ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo1.png',
                      height: 50.0,
                    ),
                    SizedBox(width: 10.0),
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
                  ],
                ),
              ),

              SizedBox(
                height: 50,
                width: 100,
                child: InkWell(
                  onTap:() async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString("token"," ");
                    Navigator.pushReplacementNamed(context, '/login_caregiver');
                  },
                  child:Row(
                    children: [
                      Icon(Icons.logout, color: Colors.white,),
                      Text(
                        'logout',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontFamily: 'Dosis',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                    ],
                  ) ,

                ),
              )
            ],
          ),
        ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[

                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/add.svg',height: 128,),
                        SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.pushNamed(context,'/add_person');
                                Navigator.pushNamed(context, '/add_person' );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {return Color(0xFF0F1D44);},
                                ),
                              ),
                              child:  Text('Add Speaker', style: cardTextStyle,),
                            )
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/speakers.svg',height: 128,),
                        SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context,'/speakers' );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {return Color(0xFF0F1D44);},
                                ),
                              ),
                              child:  Text('Speakers', style: cardTextStyle,),
                            )
                        ),
                      ],
                    ),
                  ),
                  Card(

                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/Scheduler.svg',height: 128,),
                        SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {return Color(0xFF0F1D44);},
                                ),
                              ),
                              child:  Text('Scheduler', style: cardTextStyle,),
                            )
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/reminder.svg',height: 128,),
                        SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {return Color(0xFF0F1D44);},
                                ),
                              ),
                              child:  Text('Reminder', style: cardTextStyle,),
                            )
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/Patient.svg',height: 128,),
                        SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.pushNamed(context,'/create_patient');
                                Navigator.pushNamed(context, '/create_patient' );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {return Color(0xFF0F1D44);},
                                ),
                              ),
                              child:  Text('Create Patient', style: cardTextStyle,),
                            )
                        ),

                      ],
                    ),
                  ),
                  // Text(
                  //   ' ${homeemail}',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     letterSpacing: 2.0,
                  //     fontFamily: 'Dosis',
                  //     fontSize: 10.0,
                  //
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



