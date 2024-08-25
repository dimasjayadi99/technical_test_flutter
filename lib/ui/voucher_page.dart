import 'package:flutter/material.dart';

class VoucherPage extends StatefulWidget{
  const VoucherPage({super.key});

  @override
  VoucherPageState createState() => VoucherPageState();
}

class VoucherPageState extends State<VoucherPage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Voucher Page")),
    );
  }

}