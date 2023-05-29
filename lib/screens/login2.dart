import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/gradient_ui_widgets.dart' as a;
//import 'dart:ui';
import 'package:drop_shadow/drop_shadow.dart';
class login2 extends StatefulWidget {
  const login2({Key? key}) : super(key: key);

  @override
  State<login2> createState() => _login2State();
}

class _login2State extends State<login2> {
  Gradient g1 = LinearGradient(
    colors: [
      //Color(0xFF18B1BD), //blue gradient
      //Color(0xFF060FA1),
      Color(0xff0e6f9d),
      Color(0xff062f42),
      // Color(0xFF309F93), //green gradient
      // Color(0xFF19524C),

    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/1981451.jpg'),
              fit: BoxFit.cover,
            ),

          ),
          child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0,120.0,30.0,0.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/logo1.png',
                        height: 100.0,
                      ),
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
                      SizedBox(height: 50.0),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.white)
                          ),
                          labelText:'Enter your username',
                          labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Colors.white)
                          ),
                          labelText:'Enter your password',
                          labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 50.0),
                      a.GradientFloatingActionButton.extended(
                        onPressed: () {},
                        label: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        shape: StadiumBorder(),
                        gradient: g1,
                      ),
                      SizedBox(height: 30.0),

                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}

