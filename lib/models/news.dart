// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.id,
    this.title,
    this.summary,
    this.link,
    this.published,
    this.isFav,
  });

  int id;
  String title;
  String summary;
  String link;
  String published;
  bool isFav;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    id: json["id"],
    title: json["title"],
    summary: json["summary"],
    link: json["link"],
    published: json["published"],
    isFav: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "summary": summary,
    "link": link,
    "published": published,
    "isFav": false,
  };
}
