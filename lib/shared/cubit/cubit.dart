
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/crypto_model.dart';
import 'package:stock_twit/models/etf_model.dart';
import 'package:stock_twit/models/forex_model.dart';
import 'package:stock_twit/models/news_model.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/models/ticker_model.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

      cryptData=CryptoModel.fromJson(value.data['data']);
      emit(StockSuccessCryptData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorCryptoData(error: error.toString()));
    });
  }


  List<Map<String,dynamic>> stockSymbolData=[];
  void GetStockSymbolData(){
    emit(StockLoadingStockSymbolData());
    DioHelper.getData(path: 'quote/TWTR,GOOGL,TSLA,AAPL',).then((value) {

      value.data.forEach((element) {

        stockSymbolData.add(element);

      });
      emit(StockSuccessStockSymbolData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorStockSymbolData(error: error.toString()));
    });
  }
  TickerModel? tickerData;
  void GetTickerData({required String from,required String to,required String symbol}){
    emit(StockLoadingEtfData());
    DioHelper.getData(path: 'historical-price-full/${symbol}',query: {
      'from': from,
      'to':to
    }).then((value) {

      tickerData=TickerModel.fromJson(value.data);
      emit(StockSuccessTickerData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorTickerData(error: error.toString()));
    });
  }
  late TooltipBehavior tooltipBehavior;
  List<DateTime> drop=[] ;
  String? dropdownValue ;
void changeValue({required String value}){
  dropdownValue=value;
  emit(StockSuccesschangevalue());

}






}