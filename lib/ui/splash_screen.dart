import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_version.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>{

  // two second
  final int timer = 2;

  String versionApp = "";

  @override
  void initState() {
    super.initState();
    _redirectPage();
    _initializeAppVersion();
  }

  _initializeAppVersion() async {
    String appVersion = await AppVersionUtils().getAppVersion();
    setState(() {
      versionApp = "Versi $appVersion";
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // redirect to introduction page or homepage
  void _redirectPage() async {
    Timer(Duration(seconds: timer), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8C20A),
      body: Stack(
        children:
        [
          const Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Payuung", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
              Text("pribadi", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Roboto')),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                versionApp,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),

        ]
      ),
    );
  }

}