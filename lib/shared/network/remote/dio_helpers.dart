

import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://financialmodelingprep.com/api/v3/stock_market/',
        receiveDataWhenStatusError: true,
        queryParameters: {
          'apikey':'c17086703ad7c1b7087e9d802ba67d56'
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
}