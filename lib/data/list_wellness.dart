import 'package:technical_test/model/wellness_model.dart';

import '../widget/card_wellness.dart';

final List<WellnessModel> listWellness = [
  WellnessModel(idWellness: 1, imageWellness: 'assets/indomaret.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000),
  WellnessModel(idWellness: 2, imageWellness: 'assets/grab.png', titleWellness: 'Voucher Grab Indonesia', priceWellness: 25000),
  WellnessModel(idWellness: 3, imageWellness: 'assets/excelso.jpg', titleWellness: 'Voucher Excelso Keren', priceWellness: 25000),
  WellnessModel(idWellness: 4, imageWellness: 'assets/alfamart.png', titleWellness: 'Voucher Alfamart', priceWellness: 25000),
  WellnessModel(idWellness: 5, imageWellness: 'assets/indomaret.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000),
  WellnessModel(idWellness: 6, imageWellness: 'assets/grab.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000),
];

Future<List<BuildCardWellness>> dummyWellness() async {
  final List<BuildCardWellness> listDummy = listWellness
      .map((wellnessModel) => BuildCardWellness(wellnessModel: wellnessModel))
      .toList();
  return listDummy;
}