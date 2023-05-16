class CryptoModel{
  List<Data> data=[];
  CryptoModel.fromJson(List<dynamic>json){
    json.forEach((element) {
      data.add(Data.fromJson(element));
    });

  }
}

class Data{
  int? id;
  String? name;
  String? symbol;
  dynamic num_market_pairs;
  String? date_added;
  dynamic max_supply;
  dynamic circulating_supply;
  dynamic total_supply;
  dynamic last_updated;
  DataUSD? dataUSD;
  Data.fromJson(dynamic json){
    id=json['id'];
    name=json['name'];
    symbol=json['symbol'];
    num_market_pairs=json['num_market_pairs'];
    date_added=json['date_added'];
    max_supply=json['max_supply'];
    circulating_supply=json['circulating_supply'];
    total_supply=json['total_supply'];
    last_updated=json['last_updated'];
    dataUSD=json['quote']['USD'];
  }
}

class DataUSD{
  dynamic price;
  dynamic volume_24h;
  dynamic volume_change_24h;
  dynamic percent_change_1h;
  dynamic percent_change_24h;
  dynamic percent_change_7d;
  dynamic percent_change_30d;
  dynamic percent_change_60d;
  dynamic percent_change_90d;
  dynamic market_cap;
  dynamic market_cap_dominance;
  dynamic fully_diluted_market_cap;
  String? last_updated;

  DataUSD.fromJson(Map<String,dynamic> json){
   price=json['price'];
   volume_24h=json['volume_24h'];
   volume_change_24h=json['volume_change_24h'];
   percent_change_1h=json['percent_change_1h'];
   percent_change_24h=json['percent_change_24h'];
   percent_change_7d=json['percent_change_7d'];
   percent_change_30d=json['percent_change_30d'];
   percent_change_60d=json['percent_change_60d'];
   percent_change_90d=json['percent_change_0d'];
   market_cap=json['market_cap'];
   market_cap_dominance=json['market_cap_dominance'];
   fully_diluted_market_cap=json['fully_diluted_market_cap'];
   last_updated=json['last_updated'];
  }



}