import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Gradient g1 = LinearGradient(
    colors: [
      Color(0xFF21409B), //blue gradient
      Color(0xFF0F1D44),
    ],
  );
  Gradient g2 = LinearGradient(
    colors: [
      Color(0xFF794482), //purple gradient
      Color(0xFF39203D),
    ],
  );
  Gradient g3 = LinearGradient(
    colors: [
      Color(0xffb75244), //blue gradient
      Color(0xff6b3028),
    ],
  );
  String homeemail="";
  bool homeflag = false;


  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    String myargs = args.toString();
    Map<String, dynamic> homemap = jsonDecode(myargs);
    homeemail = homemap["email"];
    // final Object? homeemail = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background4.PNG'),
                    fit: BoxFit.cover,
                  ),
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
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("token"," ");
                          Navigator.pushReplacementNamed(context, '/login');
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
                              ),),
                          ],
                        ) ,

                      ),
                    )
                  ],
                ),
              ),
              // Text('hii $homeemail'), ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              SizedBox(height: 30.0),
              // ListView.builder(
              //     itemCount: 3,
              //     itemBuilder: (context, index){
              //       return DropShadow(
              //         borderRadius: 20,
              //         child: Container(
              //           color: Colors.white,
              //           child: Column(
              //             children: <Widget> [
              //               Image.asset(
              //                 'assets/home_pics/talk.png',
              //                 width: 400.0,
              //               ),
              //               SizedBox(height: 10.0),
              //               Text(
              //                 "Have A Conversation",
              //                 style: TextStyle(
              //                   fontSize: 25.0,
              //                   fontWeight: FontWeight.w400,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //               SizedBox(height: 10.0),
              //               a.GradientFloatingActionButton.extended(
              //                 onPressed: () {
              //                   Navigator.pushNamed(context, '/speech_rec');
              //                 },
              //                 label: Text(
              //                   "Start",
              //                   style: TextStyle(
              //                     fontSize: 25.0,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //                 icon: Icon(Icons.arrow_right_sharp, size: 40.0,),
              //                 shape: StadiumBorder(),
              //                 gradient: g1,
              //               ),
              //               SizedBox(height: 20.0),
              //             ],
              //           ),
              //         ),
              //         color: Colors.black54,
              //         offset: Offset(2.0, 2.0),
              //       );
              //     }
              // ),
              DropShadow(
                borderRadius: 20,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget> [
                      Image.asset(
                        'assets/home_pics/talk.png',
                        width: 400.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Have A Conversation",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      a.GradientFloatingActionButton.extended(
                        heroTag: 'speechrecordbtn',
                        onPressed: () {
                          startconversation();
                        },
                        label: Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        icon: Icon(Icons.arrow_right_sharp, size: 40.0,),
                        shape: StadiumBorder(),
                        gradient: g1,
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
              SizedBox(height: 30.0),
              DropShadow(
                borderRadius: 20,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget> [
                      Image.asset(
                        'assets/home_pics/puzzle.png',
                        width: 400.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Memory Puzzle Game",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      a.GradientFloatingActionButton.extended(
                        heroTag: 'gamebtn',
                        onPressed: () {
                          //Navigator.pushNamed(context, '/home');
                        },
                        label: Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        icon: Icon(Icons.arrow_right_sharp, size: 40.0,),
                        shape: StadiumBorder(),
                        gradient: g2,
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
              SizedBox(height: 30.0),
              DropShadow(
                borderRadius: 20,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget> [
                      Image.asset(
                        'assets/home_pics/story.png',
                        width: 400.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Tell Me A Story",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      a.GradientFloatingActionButton.extended(
                        heroTag: 'storyreadbtn',
                        onPressed: () {
                          Navigator.pushNamed(context, '/story_read');
                        },
                        label: Text(
                          "Start",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        icon: Icon(Icons.arrow_right_sharp, size: 40.0,),
                        shape: StadiumBorder(),
                        gradient: g3,
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
              ),
              SizedBox(height: 30.0),
            ]
        ),
      ),
    );
    // return Scaffold(
    //   body: ListView.builder(
    //                 itemCount: 3,
    //                 itemBuilder: (context, index){
    //                   return DropShadow(
    //                     borderRadius: 20,
    //                     child: Container(
    //                       color: Colors.white,
    //                       child: Column(
    //                         children: <Widget> [
    //                           Image.asset(
    //                             'assets/home_pics/talk.png',
    //                             width: 400.0,
    //                           ),
    //                           SizedBox(height: 10.0),
    //                           Text(
    //                             "Have A Conversation",
    //                             style: TextStyle(
    //                               fontSize: 25.0,
    //                               fontWeight: FontWeight.w400,
    //                               color: Colors.black,
    //                             ),
    //                           ),
    //                           SizedBox(height: 10.0),
    //                           a.GradientFloatingActionButton.extended(
    //                             onPressed: () {
    //                               Navigator.pushNamed(context, '/speech_rec');
    //                             },
    //                             label: Text(
    //                               "Start",
    //                               style: TextStyle(
    //                                 fontSize: 25.0,
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                             ),
    //                             icon: Icon(Icons.arrow_right_sharp, size: 40.0,),
    //                             shape: StadiumBorder(),
    //                             gradient: g1,
    //                           ),
    //                           SizedBox(height: 20.0),
    //                         ],
    //                       ),
    //                     ),
    //                     color: Colors.black54,
    //                     offset: Offset(2.0, 2.0),
    //                   );
    //                 }
    //             ),
    // );

  }

  void startconversation() async{
    homeflag = await audio_sample_exists(homeemail);

    setState(() {
      print(homeemail + "," + "$homeflag");
    });
    if(homeflag==true){
      // Navigator.pushNamed(context, '/speech_rec', arguments: '''{"email":"${homeemail}"}''');
      Navigator.pushNamed(context, '/face', arguments: '''{"email":"${homeemail}"}''');
    }
    else {
      Navigator.pushNamed(context, '/sample_record', arguments: '''{"email":"${homeemail}"}''');
    }

  }
  Future<bool> audio_sample_exists(String email) async{
    final response = await http.get(Uri.parse('http://${APIConfig.ipAddress}/conversation_analysis/check_audio_exists/?email=$email'));
    final data = response.body;
    Map mymap = jsonDecode(data);
    print("AUDIO FLAG IS: ${mymap['audio_flag']}");
    return mymap['audio_flag'];
  }
}
