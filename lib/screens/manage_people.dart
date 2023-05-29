
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


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

class manage_people extends StatefulWidget {
  @override
  _manage_peopleState createState() => _manage_peopleState();
}

class _manage_peopleState extends State<manage_people> {
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

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   toolbarHeight: 55,
      //   title: Text('Add Person',
      //     style:TextStyle(fontFamily: 'Montserrat Medium',
      //         color: Colors.white,
      //         fontSize: 30),),
      //   centerTitle: true,
      //   // leading: IconButton(icon: Icon(Icons.arrow_back),
      //   //     // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaregiverScreen()))
      //   //     onPressed: (){
      //   //
      //   //     },
      //   // ),
      //   flexibleSpace: Container(
      //     height: 150,
      //     decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage('assets/top_header.png'),
      //             fit: BoxFit.fill
      //         )
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: Text('Manage People', style: TextStyle(fontSize:25),),
        centerTitle: true,
        toolbarHeight: 100.0,
        backgroundColor: Color(0xFF0F1D44),
      ),
       body: Center(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                // gallery of people to remove or edit their info

                ElevatedButton.icon(
                    onPressed: () { Navigator.pushNamed(context, '/add_person');},
                    icon: Icon(Icons.add),
                    label: Text('Add New Person')),
      //           image !=null
      //               ?ClipOval(
      //             child: Image.file(
      //               image!,
      //               width: 150,
      //               height: 57,
      //               fit: BoxFit.fill,),
      //           )
      //               :Image.asset('assets/brain.jpg',height: 57,),
      //           // Button to access the gallery.
      //           SizedBox(height: 20),
      //           // Two text fields for name and description.
      //           TextField(
      //               decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 labelText: 'Name',
      //                 hintText: 'Enter name',
      //               )),
      //           SizedBox(height: 10),
      //           TextField(
      //               decoration: InputDecoration(
      //                 border: OutlineInputBorder(),
      //                 labelText: 'Relationship status',
      //                 hintText: 'Enter more info',
      //               )),
      //
      //           SizedBox(height: 20),
      //
      //           ElevatedButton.icon(
      //               style: ButtonStyle(
      //                 overlayColor: MaterialStateProperty.resolveWith<Color?>(
      //                       (Set<MaterialState> states) {
      //                     if (states.contains(MaterialState.pressed))
      //                       return Colors.deepOrange[300];
      //                     return null;
      //                   },
      //                 ),
      //               ),
      //               onPressed: () => pickImage(ImageSource.gallery),
      //               icon: Icon(Icons.camera_alt),
      //               label: Text('Access Gallery')),
      //
      //           SizedBox(height: 15),
      //
      //           // Button to save info with an icon and text on it.
      //           ElevatedButton.icon(
      //               style: ButtonStyle(
      //                 overlayColor: MaterialStateProperty.resolveWith<Color?>(
      //                       (Set<MaterialState> states) {
      //                     if (states.contains(MaterialState.pressed))
      //                     {
      //                       return Colors.deepOrange[300];
      //                     }
      //                     return Colors.deepOrange[300];
      //                   },
      //                 ),
      //               ),
      //               onPressed : () {},
      //               icon : Icon (Icons.save) ,
      //               label : Text('Save Info')) ,
      //
              ],   ),
          ),
       ),
       ),
       ); } }