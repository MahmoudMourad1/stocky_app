class TickerModel{
  String? symbol;
  List<Historical> data=[];
  TickerModel.fromJson(Map<String,dynamic> json){
    symbol=json['symbol'];
    json['historical'].forEach((element){
      data.add(Historical.fromJson(element));
    });
  }
}

class Historical{
  String? date;
  dynamic open;
  dynamic high;
  dynamic low;
  dynamic close;
  dynamic adjClose;
  dynamic volume;
  dynamic unadjustedVolume;
  dynamic change;
  dynamic changePercent;
  dynamic vwap;
  String? label;
  dynamic changeOverTime;
  Historical.fromJson(Map<String,dynamic> json){
    date=json['date'];
    open=json['open'];
    high=json['high'];
    low=json['low'];
    close=json['close'];
    adjClose=json['adjClose'];
    volume=json['volume'];
    unadjustedVolume=json['unadjustedVolume'];
    change=json['change'];
    changePercent=json['changePercent'];
    vwap=json['vwap'];
    label=json['label'];
    changeOverTime=json['changeOverTime'];
  }
}