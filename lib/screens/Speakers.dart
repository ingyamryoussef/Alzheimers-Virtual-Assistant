import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';
import 'speaker_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';


class speaker extends StatefulWidget {
  const speaker({Key? key}) : super(key: key);

  @override
  State<speaker> createState() => _speakerState();
}

class _speakerState extends State<speaker> {

  // final url = "http://192.168.56.1:8001/caregiver_speakers/7";
  final url="http://${APIConfig.ipAddress}/speaker_recognition/Gallery/";

  List Speakers=[];

  Future<void> fetchPost(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString(token);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          // other headers if needed
        },
      );
      if (response.statusCode == 200) {
        print("gamed");
        print(response.body);
      } else {
        print("error1");
      }
      final jsonData = jsonDecode(response.body) as List;
      setState(() {
        Speakers = jsonData;
      });
      print(jsonData[0]);
      print(Speakers[0]);
    } catch (e) {
      print("error2: $e");
    }
  }

  // List Speakers=[
  //   {
  //     "id":"1",
  //     "picture":"https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg",
  //     "name":"Ahmed",
  //     "relationShip":"Father"
  //   },
  //   {
  //     "id":"2",
  //     "picture":'https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=',
  //     "name":"Mona",
  //     "relationShip":"Mother"
  //   },
  //   {
  //     "id":"3",
  //     "picture":'https://www.leisureopportunities.co.uk/images/995586_746594.jpg',
  //     "name":"Aly",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"4",
  //     "picture":'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
  //     "name":"Hassan",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"5",
  //     "picture":'https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=',
  //     "name":"Fady",
  //     "relationShip":"friend"
  //   },
  //   {
  //     "id":"6",
  //     "picture":'https://www.leisureopportunities.co.uk/images/995586_746594.jpg',
  //     "name":"Moustafa",
  //     "relationShip":"Friend"
  //   },
  //   {
  //     "id":"7",
  //     "picture":'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
  //     "name":"Saleh",
  //     "relationShip":"Friend"
  //   },
  //   {
  //     "id":"8",
  //     "picture":'https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=',
  //     "name":"Basel",
  //     "relationShip":"Friend"
  //   },
  //   {
  //     "id":"9",
  //     "picture":'https://www.leisureopportunities.co.uk/images/995586_746594.jpg',
  //     "name":"Mona",
  //     "relationShip":"Mother"
  //   },
  //   {
  //     "id":"10",
  //     "picture":'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
  //     "name":"Aly",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"11",
  //     "picture":'https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=',
  //     "name":"Hassan",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"12",
  //     "picture":'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
  //     "name":"Aly",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"13",
  //     "picture":'https://www.leisureopportunities.co.uk/images/995586_746594.jpg',
  //     "name":"Hassan",
  //     "relationShip":"Brother"
  //   },
  //   {
  //     "id":"14",
  //     "picture":'https://sb.kaleidousercontent.com/67418/1920x1545/c5f15ac173/samuel-raita-ridxdghg7pw-unsplash.jpg',
  //     "name":"Fady",
  //     "relationShip":"friend"
  //   },
  //   {
  //     "id":"15",
  //     "picture":'https://media.istockphoto.com/id/1300512215/photo/headshot-portrait-of-smiling-ethnic-businessman-in-office.jpg?b=1&s=170667a&w=0&k=20&c=TXCiY7rYEvIBd6ibj2bE-VbJu0rRGy3MlHwxt2LHt9w=',
  //     "name":"Moustafa",
  //     "relationShip":"Friend"
  //   },
  //   {
  //     "id":"16",
  //     "picture":'https://www.leisureopportunities.co.uk/images/995586_746594.jpg',
  //     "name":"Saleh",
  //     "relationShip":"Friend"
  //   },
  // ];
  // List Speakers=[];
  // @override
  // void initState() {
  //
  //   fetchPosts(map["email"]);
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    fetchPost("token");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(

        title: Text('Speakers',
          style:TextStyle(fontFamily: 'Montserrat Medium',
              color: Colors.white,
              fontSize: 30),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body:
      Speakers==null || Speakers.isEmpty?
      Center(child: CircularProgressIndicator()):
      Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: GridView.builder(
            itemCount: Speakers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 10),
            itemBuilder: (context,i){
              return GestureDetector(
                onTap: ()=>Get.to(SpeakerDetails(),
                    arguments:{
                      'id':Speakers[i]["id"],
                      'picture':"http://${APIConfig.ipAddress}//media/"+Speakers[i]["img_path"].toString(),
                      'speakerName': Speakers[i]["recognized_name"],
                      'speakerRelationship': Speakers[i]["relationship"],
                    }
                ),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("http://${APIConfig.ipAddress}//media/"+Speakers[i]["img_path"].toString()),
                          radius: 20,
                        ),
                      ),
                      Text("${Speakers[i]["recognized_name"]}",style:TextStyle(fontFamily: 'Montserrat Medium',
                          color: Colors.black,
                          fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("${Speakers[i]["relationship"]}",style:TextStyle(fontFamily: 'Montserrat Medium',
                          color: Colors.black,
                          fontSize: 20),),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
