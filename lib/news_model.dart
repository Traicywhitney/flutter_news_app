class NewsModel {
  String? status;
  List<Data>? data;

  NewsModel({this.status, this.data});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? source;
  String? title;
  String? link;
  String? description;
  String? pubDate;

  Data({this.source, this.title, this.link, this.description, this.pubDate});

  Data.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    title = json['title'];
    link = json['link'];
    description = json['description'];
    pubDate = json['pubDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['title'] = this.title;
    data['link'] = this.link;
    data['description'] = this.description;
    data['pubDate'] = this.pubDate;
    return data;
  }
}