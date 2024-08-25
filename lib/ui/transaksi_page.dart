import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget{
  const TransaksiPage({super.key});

  @override
  TransaksiPageState createState() => TransaksiPageState();
}

class TransaksiPageState extends State<TransaksiPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Transaksi Page")),
    );
  }

}