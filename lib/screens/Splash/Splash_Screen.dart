import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/Home_Screen.dart';
import '../setting_screen/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => HomeScreen()),
          (route) => false);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: (providerVar.isSwitch == true)
          ? Colors.transparent
          : Color(0xff5084E9),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image(
            image: AssetImage('assets/Image/810522.png'),
            fit: BoxFit.fill,
          )),
          Text(
            'City Weather',
            style: TextStyle(fontSize: 22, color: Colors.white),
          )
        ],
      )),
    );
  }
}
