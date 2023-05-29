// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:file_picker/file_picker.dart';
// class VoiceRecorder extends StatefulWidget {
//   @override _VoiceRecorderState createState() => _VoiceRecorderState();
// }
// class _VoiceRecorderState extends State<VoiceRecorder> {
//   bool _isRecording = false;
//   bool _isUploading = false;
//   File _recordedFile;
//   void _startRecording() async {
//     if (await Permission.microphone.request().isGranted) {
//       setState(() { _isRecording = true; });
//       final Directory appDirectory = await getApplicationDocumentsDirectory();
//       final String filePath = '${appDirectory.path}/recording.wav';
//       await Process.run('arecord', ['-D', 'hw:1,0', '-f', 'cd', '-t', 'wav', '-q', '-r', '44100', '-d', '10', filePath]);
//       setState(() { _recordedFile = File(filePath); _isRecording = false;
//       _isUploading = true; });
//       await _uploadVoiceFile(_recordedFile); }
//     else { print('Microphone permission not granted'); }
//   }
//   Future<void> _uploadVoiceFile(File voiceFile) async {
//     final url = Uri.parse('http://yourbackendserver.com/rcvoice');
//     final request = http.MultipartRequest('POST', url);
//     request.files.add(await http.MultipartFile.fromPath('voice_file', voiceFile.path));
//     final response = await request.send();
//     if (response.statusCode == 200) { print('Voice file uploaded successfully'); }
//     else { print('Voice file upload failed with status ${response.statusCode}'); }
//     setState(() { _isUploading = false; });
//   }
//   @override Widget build(BuildContext context) {
//     return Column( children: <Widget>[ SizedBox(height: 16.0), if (_recordedFile != null) Text('Recorded file: ${_recordedFile.path}'), if (_isRecording) Text('Recording...'), if (_isUploading) Text('Uploading...'), RaisedButton( child: Text(_isRecording ? 'Stop recording' : 'Start recording'), onPressed: _isUploading ? null : _isRecording ? () {} : _startRecording, ), ], ); } }