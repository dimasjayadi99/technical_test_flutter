import 'package:flutter/material.dart';
import 'package:technical_test/model/wellness_model.dart';

class BuildCardWellness extends StatelessWidget {

  final WellnessModel wellnessModel;

  const BuildCardWellness({super.key, required this.wellnessModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(wellnessModel.imageWellness, width: double.infinity, height: 80, fit: BoxFit.contain),
                const SizedBox(height: 10),
                Text("${wellnessModel.titleWellness} ${wellnessModel.priceWellness}", style: const TextStyle(fontSize: 12),),
                const SizedBox(height: 10),
                Text("Rp. ${wellnessModel.priceWellness}", style: const TextStyle(fontSize: 12),)
              ],
            ),
          ),
        ),
      );
  }
}