
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_twit/models/crypto_model.dart';
import 'package:stock_twit/models/etf_model.dart';
import 'package:stock_twit/models/forex_model.dart';
import 'package:stock_twit/models/news_model.dart';
import 'package:stock_twit/models/quote_model.dart';
import 'package:stock_twit/models/stock_model.dart';
import 'package:stock_twit/models/ticker_model.dart';
import 'package:stock_twit/shared/cubit/states.dart';
import 'package:stock_twit/shared/network/remote/dio_helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockCubit extends Cubit<StockStates>{
  StockCubit():super(StockInitialState());

   static StockCubit get(context) => BlocProvider.of(context);
  





  StockModel? mostGainerData;
  String apikeymost='c62d7aac92f7629de9f54d7b85e57c84';
  void GetMostGainerData(){

    emit(StockLoadingMostGainer());
    DioHelper.getData(path: 'stock_market/gainers',query: {
      'apikey': apikeymost,
    }).then((value) {
      // print(value.data[0]);
      mostGainerData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostGainer());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorMostGainer(error: error.toString()));
      apikeymost='9d34c9c9e64854c638f155d0b0472aa2';
      GetMostGainerData();
    });
  }


  StockModel? mostLoserData;
  String apikeyloser='f0b532c84584c55910e0a5e547ab972c';
  void GetMostLoserData(){

    emit(StockLoadingMostLosers());
    DioHelper.getData(path: 'stock_market/losers',query: {
      'apikey':apikeyloser,
    }).then((value) {
      // print(value.data[0]);
      mostLoserData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostLosers());
    }).catchError((error){
      emit(StockErrorMostLosers(error: error.toString()));
      apikeyloser='f2f37df54b18a1fe6a86fe74d1f1fda8';
      GetMostLoserData();
    });
  }


  StockModel? mostActivesData;
  String apikeyactive='56e462c0354f709cebbf4658fe5c8944';
  void GetMostActivesData(){

    emit(StockLoadingMostActives());
    DioHelper.getData(path: 'stock_market/actives',query: {
      'apikey':apikeyactive,
    }).then((value) {

      mostActivesData=StockModel.fromJaon(value.data);
      emit(StockSuccessMostActives());
    }).catchError((error){
      emit(StockErrorMostActives(error: error.toString()));
      apikeyactive='72dd1f5559f0ac0444ae847e9d62c684';
      GetMostActivesData();
    });
  }

  ForexModel? forexData;
  void GetforexData() {
    emit(StockLoadingForexData());
    DioHelper.getData(
      path: 'fx',
    query: {
      'apikey':'b6ceb59fb70fe33c7a7d09cb9b4638b2'
    }
    ).then((value) {
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
       'apikey':'62f652ede75269ab096cf35d5a365c78',
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
    DioHelper.getData(path: 'etf/list',
    query: {
      'apikey':'5e65389a97134c3ab0cd893cd4dc2c0b'
    }
    ).then((value) {

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
  String apikeysymbol='436984c7a69b5bcd3d41c860bc2f09f8';
  void GetStockSymbolData(){

    emit(StockLoadingStockSymbolData());
    DioHelper.getData(path: 'quote/TWTR,GOOGL,TSLA,AAPL,AMZN,MSFT,FB,JPM,V,PG,JNJ,NVDA,PFE,XOM',query: {
      'apikey':apikeysymbol,
    }).then((value) {

      value.data.forEach((element) {

        stockSymbolData.add(element);

      });
      emit(StockSuccessStockSymbolData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorStockSymbolData(error: error.toString()));
      apikeysymbol='ae7a03a8fff22f117c41bcbadc6440d1';
      GetStockSymbolData();
    });
  }
  TickerModel? tickerData;
  String apikeyticker='d5b9984a4e631a7bffb4547c83bcbfd3';
  void GetTickerData({required String from,required String to,required String symbol}){

    emit(StockLoadingEtfData());
    DioHelper.getData(path: 'historical-price-full/${symbol}',query: {
      'apikey':apikeyticker,
      'from': from,
      'to':to
    }).then((value) {

      tickerData=TickerModel.fromJson(value.data);
      emit(StockSuccessTickerData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorTickerData(error: error.toString()));
      apikeyticker='b96c68b92d3dfc9c53d8c45f151102f4';
      GetTickerData(from: from, to: to, symbol: symbol);
    });
  }
  late TooltipBehavior tooltipBehavior;
  List<DateTime> drop=[] ;
  String? dropdownValue ;
void changeValue({required String value}){
  dropdownValue=value;
  emit(StockSuccesschangevalue());

}

  List<dynamic> search = [];
  String  apikeysearch='0cffeffc9d5fc1b9b730060f896b92a8';
  void getsearch(String value) {

    emit(StocketSearchLoadingState());
    DioHelper.getData(path: 'search',
        query: {
          'query': '$value',
          'limit':'10',
          'apikey': apikeysearch,
          //ee7601bb0b119225976228ed279c7cd5
          'exchange':'NASDAQ',
        }).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data;

      emit(StockSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(StockSearchErrorState(error: error.toString()));
      apikeysearch='bea56328962f85e75765d9dcf11cc0f7';
      getsearch(value);
    });
  }


  QuoteModel? quoteData;
  String apikeyquote='471d0b711da531dda3ecff3486544554';
  void GetQuoteData({required String symbol}){
    emit(StockLoadingQuoteData());
    DioHelper.getData(path: 'historical-price-full/${symbol}',
    query: {
      'apikey':apikeyquote
    }).then((value) {

      quoteData=QuoteModel.fromJson(value.data['historical']);
      emit(StockSuccessQuoteData());
    }).catchError((error){
      print(error.toString());
      emit(StockErrorQuoteData(error: error.toString()));
      apikeyquote='4c59b535910bf9adb4a40175f9943adb';
      GetQuoteData(symbol: symbol);
    });
  }

  //  QuoteModel? quoteData;
  // void GetQuoteData({required String symbol}){
  //   emit(StockLoadingQuoteData());
  //   DioHelper.getData(path: 'historical-chart/30min/${symbol}',).then((value) {
  //
  //     quoteData=QuoteModel.fromJson(value.data);
  //     emit(StockSuccessQuoteData());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(StockErrorQuoteData(error: error.toString()));
  //   });
  // }



}