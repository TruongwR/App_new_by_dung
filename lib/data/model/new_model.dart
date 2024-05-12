// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    final int? id;
    final String? title;
    final String? thumbnail;
    final String? contentHtml;
    final String? contentText;
    final int? view;
    final String? createdDate;
    final dynamic updatedDate;
    final bool? deleted;
    final List<dynamic>? hashtags;

    NewsModel({
        this.id,
        this.title,
        this.thumbnail,
        this.contentHtml,
        this.contentText,
        this.view,
        this.createdDate,
        this.updatedDate,
        this.deleted,
        this.hashtags,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        contentHtml: json["contentHtml"],
        contentText: json["contentText"],
        view: json["view"],
        createdDate: json["createdDate"],
        updatedDate: json["updatedDate"],
        deleted: json["deleted"],
        hashtags: json["hashtags"] == null ? [] : List<dynamic>.from(json["hashtags"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "contentHtml": contentHtml,
        "contentText": contentText,
        "view": view,
        "createdDate": createdDate,
        "updatedDate": updatedDate,
        "deleted": deleted,
        "hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
    };
}
