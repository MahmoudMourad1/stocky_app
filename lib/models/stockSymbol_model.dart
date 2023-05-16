class StockSymbolModel{
  String? symbol;
  String? name;
  String? exchange;
  String? mic_code;
  String? currency;
  String? datetime;
  dynamic  timestamp;
  String?  open;
  String?  hight;
  String?  low;
  String?  close;
  String?  volume;
  String? previous_close;
  String? change;
  String? percent_change;
  String? average_volume;

  StockSymbolModel.fromJson(Map<String,dynamic> json){
    symbol=json[symbol];
    name=json[name];

  }

}