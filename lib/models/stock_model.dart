class StockModel{
  List<Data> data=[];
  StockModel.fromJaon(List<dynamic>json){
    json.forEach((element) {
      data.add(Data.fromJson(element));
    });

  }
}

class Data{
  String? symbol;
  String? name;
  double? change;
  double? price;
  double? changepercentage;

  Data.fromJson(Map<String,dynamic> json){
    symbol=json['symbol'];
    name=json['name'];
    change=json['change'];
    price=json['price'];
    changepercentage=json['changepercentage'];
  }
}