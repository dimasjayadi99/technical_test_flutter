import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/data/list_wellness.dart';
import 'package:technical_test/widget/card_wellness.dart';

class DetailWellnessInitState {}

class DetailWellnessLoadingState extends DetailWellnessInitState {}

class DetailWellnessSuccessState extends DetailWellnessInitState{
  final BuildCardWellness data;
  DetailWellnessSuccessState(this.data);
}

class DetailWellnessFailedState extends DetailWellnessInitState{
  final String message;
  DetailWellnessFailedState(this.message);
}

class DetailWellnessBloc extends Cubit<DetailWellnessInitState>{
  DetailWellnessBloc() : super(DetailWellnessInitState());

  void getDetailWellness(int idWellness) async {
    final data = await dummyWellness();
    try{
      emit(DetailWellnessLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      final filterData = data.where((e) => e.wellnessModel.idWellness == idWellness).cast<BuildCardWellness>().firstOrNull;
      if(filterData != null){
        emit(DetailWellnessSuccessState(filterData));
      }else{
        emit(DetailWellnessFailedState("Data kosong"));
      }
    }catch(error){
      debugPrint("Error Message : $error");
    }
  }

}