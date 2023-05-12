class ForexModel{
  List<Data> data=[];
  ForexModel.fromJaon(List<dynamic>json){
    json.forEach((element) {
      data.add(Data.fromJson(element));
    });

  }
}

class Data{
  String? ticker;
  dynamic bid;
  dynamic ask;
  dynamic open;
  dynamic low;
  dynamic high;
  dynamic changes;
  dynamic date;


  Data.fromJson(Map<String,dynamic> json){
    ticker=json['ticker'];
    bid=json['bid'];
    ask=json['ask'];
    open=json['open'];
    low=json['low'];
    high=json['high'];
    changes=json['changes'];
    date=json['date'];
  }
}