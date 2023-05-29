// import 'package:flutter/material.dart';
// import 'dart:convert';
//
//
// class tutorial extends StatefulWidget {
//   const tutorial({Key? key}) : super(key: key);
//
//   @override
//   State<tutorial> createState() => _tutorialState();
// }
//
// class _tutorialState extends State<tutorial> {
//   @override
//   Widget build(BuildContext context) {
//     final Object? args = ModalRoute.of(context)?.settings.arguments;
//     String myargs = args.toString();
//     Map<String, dynamic> tutorialmap = jsonDecode(myargs);
//     return const Placeholder();
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_config.dart';


class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late PageController _pageController;
  int currentIndex = 0;

  List<Map<String, String>> sliderItems = [
    {
      'image': 'assets/tutorial_pics/tutorial1.png',
      'title': 'Hello and welcome to "Remember Me"! My name is Alzi and I am here to guide you through your journey.',
      'slidenum': '1',
    },
    {
      'image': 'assets/tutorial_pics/tutorial2.png',
      'title': 'Sometimes, it happens that we meet people that we don\'t remember.',
      'slidenum': '2',
    },
    {
      'image': 'assets/tutorial_pics/tutorial3.png',
      'title': 'But it\'s okay! I will help you recall the people you met before.',
      'slidenum': '3',
    },
    {
      'image': 'assets/tutorial_pics/tutorial4.PNG',
      'title': 'When you want to recognise a person whom you forgot his name, just click on \"Have A Conversation\".',
      'slidenum': '4',
    },
    {
      'image': 'assets/tutorial_pics/tutorial5.png',
      'title': 'Raise your camera to detect that person, and if you met them before, we will remind you of their name and what was your conversation about when you last met.',
      'slidenum': '5',
    },
    {
      'image': 'assets/tutorial_pics/tutorial2.png',
      'title': 'Press "Next" to record your new conversation so that we can remind you of it next time.',
      'slidenum': '6',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {


    return Container(
        color: Color(0xFFFFFFFF),
        child: PageView.builder(
          controller: _pageController,
          itemCount: sliderItems.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, i) {
            return SlideItem(sliderItems[i]);
          },
        ),
      );
  }
}

class SlideItem extends StatelessWidget {
  final Map<String, String> slide;
  bool tutorialflag = false;

  SlideItem(this.slide);

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    String myargs = args.toString();
    Map<String, dynamic> tutorialmap = jsonDecode(myargs);
    String tutorialemail = tutorialmap["email"];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:(){
                      navigate_to_home(tutorialemail, context);
                    },
                    child:SizedBox(
                      height: 50,
                      width: 100,
                      child: Row(
                        children: [
                          Text(
                            slide["slidenum"]=='6' ? 'Done': 'Skip',
                            style: TextStyle(
                              color: Colors.blue[900],
                              letterSpacing: 2.0,
                              fontFamily: 'Dosis',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),),
                          Icon(Icons.skip_next, color: Colors.blue[900],),
                        ],
                      ),
                    ) ,

                  ),
                ],
              ),
              SizedBox(height: 20,),
              Image.asset(
                slide['image']!,
                height: 300.0,
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 170,
                child: SingleChildScrollView(
                  child: Text(
                    slide['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF070F25),
                    ),
                  ),
                ),
              ),
              // Text(
              //   slide['subtitle']!,
              //   style: TextStyle(
              //     fontSize: 18.0,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.circle, color: slide["slidenum"]=='1' ? Colors.blue[900] : Colors.blue[200]),
                  Icon(Icons.circle, color: slide["slidenum"]=='2' ? Colors.blue[900] : Colors.blue[200]),
                  Icon(Icons.circle, color: slide["slidenum"]=='3' ? Colors.blue[900] : Colors.blue[200]),
                  Icon(Icons.circle, color: slide["slidenum"]=='4' ? Colors.blue[900] : Colors.blue[200]),
                  Icon(Icons.circle, color: slide["slidenum"]=='5' ? Colors.blue[900] : Colors.blue[200]),
                  Icon(Icons.circle, color: slide["slidenum"]=='6' ? Colors.blue[900] : Colors.blue[200]),
                ],
              ),
            ],
          ),
        ),
      ),
    ); //
  }
  void navigate_to_home(String email, BuildContext context) async{
    tutorialflag = await audio_sample_exists(email);
    if(tutorialflag==true){
      Navigator.pushReplacementNamed(context, '/home', arguments:'''{"email":"$email"}''' );
    }
    else{
      Navigator.pushReplacementNamed(context, '/sample_record', arguments:'''{"email":"$email"}''' );
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
