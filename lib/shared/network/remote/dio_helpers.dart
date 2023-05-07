

import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://financialmodelingprep.com/api/v3/stock_market/',
        receiveDataWhenStatusError: true,
        queryParameters: {
          'apikey':'f2f8ceb66abe450d1d5214198aabd7e6'
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