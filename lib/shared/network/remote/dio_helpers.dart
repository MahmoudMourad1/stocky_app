

import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static Dio? dio2;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://financialmodelingprep.com/api/v3/',
        receiveDataWhenStatusError: true,
        queryParameters: {
          'apikey':'c17086703ad7c1b7087e9d802ba67d56'
        }
      ),
    );
    dio2=Dio(
      BaseOptions(
          baseUrl: 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest',
          receiveDataWhenStatusError: true,
          queryParameters: {
            'apikey':'c19a2175-df2e-4bab-8fc7-cb7a1a0d34d4'
          }
      ),
    );
  }


  static Future getData({
    required String path,
    Map<String,dynamic>? query,
})async{
    return await dio!.get(path,queryParameters: query,);
  }
  static Future getCryptoData({
    required String path,
    Map<String,dynamic>? query,
  })async{
    return await dio2!.get(path,queryParameters: query,);
  }
}