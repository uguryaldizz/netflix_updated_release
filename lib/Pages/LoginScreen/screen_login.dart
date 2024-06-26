import 'package:flutter/material.dart';
import 'package:netflix/Pages/LoginScreen/Login_Desktop.dart';
import 'package:netflix/Pages/LoginScreen/Login_Mobile.dart';

class screen2 extends StatefulWidget {
  const screen2({super.key});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  String ekranTanimla(double screen) {
    if (screen <= 1920) {
      //992
      return "mobile";
    } else {
      return "normal";
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWith = MediaQuery.of(context).size.width;
    var device = ekranTanimla(screenWith);

    Widget screenType() {
      if (device == "mobile") {
        return LoginMobile();
      } else {
        return LoginDesktop();
      }
    }

    return screenType();
  }
}
