class EtfModel{
  List<Data> data=[];
  EtfModel.fromJson(List<dynamic>json){
    json.forEach((element) {
      data.add(Data.fromJson(element));
    });

  }
}

class Data{
  String? symbol;
  String? name;
  dynamic exchange;
  dynamic price;
  dynamic exchangeShortName;

  Data.fromJson(Map<String,dynamic> json){
    symbol=json['symbol'];
    name=json['name'];
    exchange=json['exchange'];
    price=json['price'];
    exchangeShortName=json['exchangeShortName'];
  }
}