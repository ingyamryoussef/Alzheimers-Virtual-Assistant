import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//import 'package:text_to_speech/text_to_speech.dart';

class storyread extends StatefulWidget {
  const storyread({Key? key}) : super(key: key);

  @override
  State<storyread> createState() => _storyreadState();
}

class _storyreadState extends State<storyread> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController controller = TextEditingController();

  double volume = 1.0;
  double pitch = 1.0;
  double speechRate = 0.5;
  List<String>? languages;
  String langCode = "en-US";
  String myStory='Couldn\'t load ...';


  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    languages = List<String>.from(await flutterTts.getLanguages);
    await _write('The fact that Henry Armstrong was buried did not seem to him to prove that he was dead: he had always been a hard man to convince. That he really was buried, the testimony of his senses compelled him to admit. His posture -- flat upon his back, with his hands crossed upon his stomach and tied with something that he easily broke without profitably altering the situation -- the strict confinement of his entire person, the black darkness and profound silence, made a body of evidence impossible to controvert and he accepted it without cavil.But dead -- no; he was only very\, very ill. He had, withal, the invalid\'s apathy and did not greatly concern himself about the uncommon fate that had been allotted to him. No philosopher was he -- just a plain, commonplace person gifted, for the time being, with a pathological indifference: the organ that he feared consequences with was torpid. So, with no particular apprehension for his immediate future, he fell asleep and all was peace with Henry Armstrong. But something was going on overhead. It was a dark summer night, shot through with infrequent shimmers of lightning silently firing a cloud lying low in the west and portending a storm. These brief, stammering illuminations brought out with ghastly distinctness the monuments and headstones of the cemetery and seemed to set them dancing. It was not a night in which any credible witness was likely to be straying about a cemetery, so the three men who were there, digging into the grave of Henry Armstrong, felt reasonably secure. Two of them were young students from a medical college a few miles away; the third was a gigantic negro known as Jess. For many years Jess had been employed about the cemetery as a man-of-all-work and it was his favourite pleasantry that he knew \'every soul in the place.\' From the nature of what he was now doing it was inferable that the place was not so populous as its register may have shown it to be. Outside the wall, at the part of the grounds farthest from the public road, were a horse and a light wagon, waiting. The work of excavation was not difficult: the earth with which the grave had been loosely filled a few hours before offered little resistance and was soon thrown out. Removal of the casket from its box was less easy, but it was taken out, for it was a perquisite of Jess, who carefully unscrewed the cover and laid it aside, exposing the body in black trousers and white shirt. At that instant the air sprang to flame, a cracking shock of thunder shook the stunned world and Henry Armstrong tranquilly sat up. With inarticulate cries the men fled in terror, each in a different direction. For nothing on earth could two of them have been persuaded to return. But Jess was of another breed. In the grey of the morning the two students, pallid and haggard from anxiety and with the terror of their adventure still beating tumultuously in their blood, met at the medical college. \'You saw it?\' cried one. \'God! yes -- what are we to do?\' They went around to the rear of the building, where they saw a horse, attached to a light wagon, hitched to a gatepost near the door of the dissecting-room. Mechanically they entered the room. On a bench in the obscurity sat the negro Jess. He rose, grinning, all eyes and teeth. \'I\'m waiting for my pay,\' he said. Stretched on a long table lay the body of Henry Armstrong, the head defiled with blood and clay from a blow with a spade.');
    myStory = await _read();
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("One Summer Night \nby Ambrose Bierce"),
          toolbarHeight: 70.0,
          backgroundColor: Color(0xff983b30),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                SizedBox(
                  width: 350,
                  height: 350,
                  child: SingleChildScrollView(
                    child: Text(
                        '$myStory',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                    ),
                  ),
                ),
              
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(
                  //   width: 200,
                  //   height: 60,
                  //   child: TextField(
                  //     controller: controller,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Enter Text',
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  ElevatedButton(
                    child: const Text("Speak"),
                    onPressed: _speak,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff983b30)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    child: const Text("Stop"),
                    onPressed: _stop,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff983b30))),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        "Volume",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Slider(
                      min: 0.0,
                      max: 1.0,
                      value: volume,
                      activeColor: Color(0xff983b30),
                      onChanged: (value) {
                        setState(() {
                          volume = value;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                          double.parse((volume).toStringAsFixed(2)).toString(),
                          style: const TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        "Pitch",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Slider(
                      min: 0.5,
                      max: 2.0,
                      value: pitch,
                      activeColor: Color(0xff983b30),
                      onChanged: (value) {
                        setState(() {
                          pitch = value;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                          double.parse((pitch).toStringAsFixed(2)).toString(),
                          style: const TextStyle(fontSize: 17)),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        "Speech Rate",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Slider(
                      min: 0.0,
                      max: 1.0,
                      value: speechRate,
                      activeColor: Color(0xff983b30),
                      onChanged: (value) {
                        setState(() {
                          speechRate = value;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                          double.parse((speechRate).toStringAsFixed(2))
                              .toString(),
                          style: const TextStyle(fontSize: 17)),
                    )
                  ],
                ),

              ),
                SizedBox(
                  height: 20,
                ),
              // if (languages != null)
              //   Container(
              //     margin: const EdgeInsets.only(left: 10),
              //     child: Row(
              //       children: [
              //         const Text(
              //           "Language :",
              //           style: TextStyle(fontSize: 17),
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         DropdownButton<String>(
              //           focusColor: Colors.white,
              //           value: langCode,
              //           style: const TextStyle(color: Colors.white),
              //           iconEnabledColor: Colors.black,
              //           items: languages!
              //               .map<DropdownMenuItem<String>>((String? value) {
              //             return DropdownMenuItem<String>(
              //               value: value!,
              //               child: Text(
              //                 value,
              //                 style: const TextStyle(color: Colors.black),
              //               ),
              //             );
              //           }).toList(),
              //           onChanged: (String? value) {
              //             setState(() {
              //               langCode = value!;
              //             });
              //           },
              //         ),
              //       ],
              //     ),
              //   )
            ]),
          ),
        ));
  }
  void initSetting() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setLanguage(langCode);
  }

  void _speak() async {
    initSetting();
    await flutterTts.speak(myStory);
  }

  void _stop() async {
    await flutterTts.stop();
  }
  Future<String> _read() async {
    String text='';
    final Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    try {

      final File file = File('${directory.path}/test_story.txt');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }
  _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/test_story.txt');
    await file.writeAsString(text);
  }
}



