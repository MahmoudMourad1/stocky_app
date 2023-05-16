
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/crypto_model.dart';
import 'package:stock_twit/models/etf_model.dart';
import 'package:stock_twit/models/forex_model.dart';
import 'package:stock_twit/models/news_model.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';

class StockCubit extends Cubit<StockStates>{
  StockCubit():super(StockInitialState());

   static StockCubit get(context) => BlocProvider.of(context);
  



  StockModel? mostGainerData;
  void GetMostGainerData(){
    emit(StockLoadingMostGainer());
    DioHelper.getData(path: 'stock_market/gainers',).then((value) {
      // print(value.data[0]);
      mostGainerData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostGainer());
    }).catchError((error){
      emit(StockErrorMostGainer(error: error.toString()));
    });
  }


  StockModel? mostLoserData;
  void GetMostLoserData(){
    emit(StockLoadingMostLosers());
    DioHelper.getData(path: 'stock_market/losers',).then((value) {
      // print(value.data[0]);
      mostLoserData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostLosers());
    }).catchError((error){
      emit(StockErrorMostLosers(error: error.toString()));
    });
  }


  StockModel? mostActivesData;
  void GetMostActivesData(){
    emit(StockLoadingMostActives());
    DioHelper.getData(path: 'stock_market/actives',).then((value) {

      mostActivesData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostActives());
    }).catchError((error){
      emit(StockErrorMostActives(error: error.toString()));
    });
  }

  ForexModel? forexData;
  void GetforexData() {
    emit(StockLoadingForexData());
    DioHelper.getData(path: 'fx',).then((value) {
      forexData = ForexModel.fromJaon(value.data);
      emit(StockSuccessForexData());
    }).catchError((error) {
      emit(StockErrorForexData(error: error.toString()));
    });
  }
    NewsModel? newsData;
    void GetNewsData(){
      emit(StockLoadingNewsData());
      DioHelper.getData(path: 'fmp/articles',query: {
        'page':0,
        'size':10,
      }).then((value) {

        newsData=NewsModel.fromJson(value.data);
        emit(StockSuccessNewsData());
      }).catchError((error){
        emit(StockErrorNewsData(error: error.toString()));
      });
    }

  EtfModel? etfData;
  void GetEtfData(){
    emit(StockLoadingEtfData());
    DioHelper.getData(path: 'etf/list',).then((value) {

      etfData=EtfModel.fromJson(value.data);
      emit(StockSuccessEtfData());
    }).catchError((error){
      emit(StockErrorEtfData(error: error.toString()));
    });
  }

  CryptoModel? cryptData;
  void GetCryptoData(){
    emit(StockLoadingCryptoData());
    DioHelper.getCryptoData(path:'cryptocurrency/listings/latest',).then((value) {
      print(value);
      print("_________________");
      print(cryptData?.data[0].name);
      cryptData=CryptoModel.fromJson(value.data);
      emit(StockSuccessCryptData());
    }).catchError((error){
      emit(StockErrorCryptoData(error: error.toString()));
    });
  }





}