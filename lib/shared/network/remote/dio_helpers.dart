

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
          'apikey':'2dba92ddbac3acdfca68251c7304ffc8'
          // """
          // 0143334a7451c5fb844aa29737aad777
          // 2dba92ddbac3acdfca68251c7304ffc8
          // 620aea5ea3c274fa0b2e0ceb29a22fe9
          // 4c59b535910bf9adb4a40175f9943adb
          // b6ceb59fb70fe33c7a7d09cb9b4638b2
          // """

          //mobile
          //e1ba3397e1b670fa8c155b08817eaa84
        }
      ),
    );
    dio2=Dio(
      BaseOptions(
          baseUrl: 'https://pro-api.coinmarketcap.com/v1/',
          receiveDataWhenStatusError: true,
          queryParameters: {
            'CMC_PRO_API_KEY':'c19a2175-df2e-4bab-8fc7-cb7a1a0d34d4'
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