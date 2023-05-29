import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
import 'package:url_launcher/url_launcher.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:alzheimer_virtual_assistant_app/classes/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'check_token.dart';





class FirstLogin extends StatefulWidget {
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {

  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate(context);
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',

    );
  }
}
