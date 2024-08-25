import 'package:flutter/material.dart';

class ExplorerPage extends StatefulWidget{
  const ExplorerPage({super.key});

  @override
  ExplorerPageState createState() => ExplorerPageState();
}

class ExplorerPageState extends State<ExplorerPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Explorer Page")),
    );
  }

}