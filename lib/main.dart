//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login2.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login3.dart';
import 'package:alzheimer_virtual_assistant_app/screens/home.dart';
import 'package:alzheimer_virtual_assistant_app/screens/speech_to_text.dart';
import 'package:alzheimer_virtual_assistant_app/screens/speech_record.dart';
import 'package:alzheimer_virtual_assistant_app/screens/story_read.dart';
import 'package:alzheimer_virtual_assistant_app/screens/signup_patient.dart';
import 'package:alzheimer_virtual_assistant_app/screens/signup_caregiver.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login_caregiver.dart';
import 'package:alzheimer_virtual_assistant_app/screens/caregiver_home.dart';
import 'package:alzheimer_virtual_assistant_app/screens/add_person.dart';
import 'package:alzheimer_virtual_assistant_app/screens/manage_people.dart';
import 'package:alzheimer_virtual_assistant_app/screens/sample_audio_record.dart';
import 'package:alzheimer_virtual_assistant_app/screens/conversation_tutorial.dart';
import 'package:alzheimer_virtual_assistant_app/screens/create_patient_account.dart';
import 'package:alzheimer_virtual_assistant_app/screens/facee.dart';
import 'package:alzheimer_virtual_assistant_app/screens/Patient.dart';
import 'package:alzheimer_virtual_assistant_app/screens/Speakers.dart';
import 'package:alzheimer_virtual_assistant_app/screens/speaker_details.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:alzheimer_virtual_assistant_app/screens/first_login.dart';

List<CameraDescription> _cameras=[];
late final CameraDescription cameraa;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  cameraa=_cameras[0];
  runApp(GetMaterialApp(
    //debugShowCheckedModeBanner: false,
    initialRoute: '/first_login',
    routes: {
      '/first_login': (context) => FirstLogin(),
      '/login': (context) => login3(),
      '/signup_patient': (context) => signup_patient(),
      '/signup_caregiver': (context) => signup_caregiver(),
      '/home': (context) => home(),
      '/speech': (context) => speech_recognition(),
      '/speech_rec': (context) => speech_record(),
      '/story_read': (context) => storyread(),
      '/login_caregiver': (context) => login_caregiver(),
      '/add_person': (context) => add_app(),
      '/caregiver_home': (context) => CaregiverScreen(),
      '/manage_people': (context) => manage_people(),
      '/sample_record': (context) => sample_record(),
      '/tutorial': (context) => SliderWidget(),
      '/create_patient': (context) => create_patient(),
      '/speakers': (context) => speaker(),
      '/speaker_details': (context) => SpeakerDetails(),
      '/face': (context) => Facee(),
      '/Patient':(context)=>Home(),


    },
  ));
}



// import 'package:flutter/material.dart';
// import 'package:social_media_recorder/audio_encoder_type.dart';
// import 'package:social_media_recorder/screen/social_media_recorder.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowMaterialGrid: false,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 140, left: 4, right: 4),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: SocialMediaRecorder(
//                   sendRequestFunction: (soundFile) {
//                     print("the current path is ${soundFile.path}");
//                   },
//                   encode: AudioEncoderType.AAC,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
