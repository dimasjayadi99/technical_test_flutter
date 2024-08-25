import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget{
  const KeranjangPage({super.key});

  @override
  KeranjangPageState createState() => KeranjangPageState();
}

class KeranjangPageState extends State<KeranjangPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Keranjang Page")),
    );
  }

}