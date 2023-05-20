import 'dart:ffi';

class QuoteModel{
  List<Statistics> data=[];
  QuoteModel.fromJson(dynamic json){
    json.forEach((element) {
      data.add(Statistics.fromJson(element));
    });
  }
}
class Statistics{
  dynamic date;
  dynamic open;
  dynamic high;
  dynamic close;
  dynamic low;
  dynamic volume;
  Statistics.fromJson(Map<String,dynamic> json){
    date=json['date'];
    open=json['open'];
    high=json['high'];
    close=json['close'];
    low=json['low'];
    volume=json['volume'];
  }
}