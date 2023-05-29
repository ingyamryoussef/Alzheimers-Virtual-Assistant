import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login_caregiver.dart';
import 'package:alzheimer_virtual_assistant_app/screens/caregiver_home.dart';
import 'package:alzheimer_virtual_assistant_app/screens/login3.dart';
import 'package:alzheimer_virtual_assistant_app/screens/home.dart';

import 'api_config.dart';
Future<Map<String, dynamic>> _authenticateCaregiverWithToken(String token) async {
  // Make an API call to authenticate the caregiver using the token
  final response = await http.post(
    Uri.parse('http://${APIConfig.ipAddress}/speaker_recognition/login_token_caregiver/'),
    headers: {'Authorization': 'Bearer $token'},
  );

  // Check the response status code
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final email = jsonResponse['email'];
    // Authentication successful, return true
    return {'authenticated': true, 'email': email};
  } else {
    // Authentication failed, return false
    return {'authenticated': false};
  }
}
Future<Map<String, dynamic>> _authenticatePatientWithToken(String token) async {
  // Make an API call to authenticate the caregiver using the token
  final response = await http.post(
    Uri.parse('http://${APIConfig.ipAddress}/speaker_recognition/login_token_patient/'),
    headers: {'Authorization': 'Bearer $token'},
  );

  // Check the response status code
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    final email = jsonResponse['email'];
    // Authentication successful, return true
    return {'authenticated': true, 'email': email};
  } else {
    // Authentication failed, return false
    return {'authenticated': false};
  }
}

Future<void> checkTokenAndNavigate(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final Token = prefs.getString("token");
  print(Token);

  if (Token != null) {
    var isAuthenticatedcaregiver = await _authenticateCaregiverWithToken(Token);
    final isAuthenticatedpatient=await _authenticatePatientWithToken(Token);
    if (isAuthenticatedcaregiver['authenticated']) {
      Navigator.pushNamed(
        context,
        '/caregiver_home',
        // arguments: isAuthenticatedcaregiver['email'],
        arguments:  '''{"email":"${isAuthenticatedcaregiver['email']}"}''',
      );
    }

    else if(isAuthenticatedpatient['authenticated']){
      Navigator.pushNamed(
        context,
        '/home',
        arguments:  '''{"email":"${isAuthenticatedpatient['email']}"}''',
      );
    }
    else if(!isAuthenticatedcaregiver['authenticated']){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => login_caregiver(),
        ),
      );
    }

    else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => login_caregiver(),
        ),
      );
    }
  }
  else  {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => login_caregiver(),
      ),
    );
  }
}

