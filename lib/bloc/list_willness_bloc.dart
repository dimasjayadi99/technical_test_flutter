import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/data/list_wellness.dart';
import 'package:technical_test/widget/card_wellness.dart';

class ListWellnessInitState {}

class ListWellnessLoadingState extends ListWellnessInitState {}

class ListWellnessSuccessState extends ListWellnessInitState{
  final List<BuildCardWellness> list;
  ListWellnessSuccessState(this.list);
}

class ListWellnessFailedState extends ListWellnessInitState{
  final String message;
  ListWellnessFailedState(this.message);
}

class ListWellnessBloc extends Cubit<ListWellnessInitState>{
  ListWellnessBloc() : super(ListWellnessInitState());

  void getListWellness() async {
    final data = await dummyWellness();
    try{
      emit(ListWellnessLoadingState());
      await Future.delayed(const Duration(seconds: 1));
      if(data.isNotEmpty){
        emit(ListWellnessSuccessState(data));
      }else{
        emit(ListWellnessFailedState("Data kosong"));
      }
    }catch(error){
      debugPrint("Error Message : $error");
    }
  }

}