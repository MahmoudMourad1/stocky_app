class NewsModel{
  List<ContentData> data=[];

  NewsModel.fromJson(Map<String,dynamic> json){
    json['content'].forEach((element) {
      data.add(ContentData.fromJson(element));
    });
  }
}

class ContentData{

  String? title;
  String? date;
  String? content;
  String? tickers;
  String? image;
  String? link;
  String? author;
  String? site;

  ContentData.fromJson(Map<String,dynamic>json){
    title=json['title'];
    date=json['date'];
    content=json['content'];
    tickers=json['tickers'];
    image=json['image'];
    link=json['link'];
    author=json['author'];
    site=json['site'];
  }
}