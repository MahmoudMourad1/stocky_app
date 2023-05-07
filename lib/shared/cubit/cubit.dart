import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';

class StockCubit extends Cubit<StockStates>{
  StockCubit():super(StockInitialState());

   static StockCubit get(context) => BlocProvider.of(context);
  
  
  StockModel? mostGainerData;
  void GetMostGainerData(){
    emit(StockLoadingMostGainer());
    DioHelper.getData(path: 'gainers',).then((value) {
      print(value.data[0]);
      mostGainerData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostGainer());
    }).catchError((error){
      emit(StockErrorMostGainer(error: error.toString()));
    });
  }


  StockModel? mostLoserData;
  void GetMostLoserData(){
    emit(StockLoadingMostLosers());
    DioHelper.getData(path: 'losers',).then((value) {
      print(value.data[0]);
      mostGainerData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostLosers());
    }).catchError((error){
      emit(StockErrorMostLosers(error: error.toString()));
    });
  }


  StockModel? mostActivesData;
  void GetMostActivesData(){
    emit(StockLoadingMostGainer());
    DioHelper.getData(path: 'actives',).then((value) {
      print(value.data[0]);
      mostGainerData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostGainer());
    }).catchError((error){
      emit(StockErrorMostGainer(error: error.toString()));
    });
  }
}