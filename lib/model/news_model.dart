import 'dart:convert';

NewsResponse welcomeFromJson(String str) =>
    NewsResponse.fromJson(json.decode(str));

String welcomeToJson(NewsResponse data) => json.encode(data.toJson());

class NewsResponse {
  String status;
  int totalResults;
  List<Article> articles;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"] ?? "-",
        title: json["title"] ?? "-",
        description: json["description"] ?? "-",
        url: json["url"] ?? "-",
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"] ?? "00-00-00"),
        content: json["content"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}
