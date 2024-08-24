import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget{
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Introduction Page")),
    );
  }

}