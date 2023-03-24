import 'package:resume_builder/models/source.model.dart';

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      // check if author is null
      author: json['author'] == null ? 'Unknown' : json['author'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      url: json['url'] == null ? '' : json['url'] as String,
      urlToImage: json['urlToImage'] == null
          ? 'https://picsum.photos/250?image=9'
          : json['urlToImage'] as String,
      publishedAt:
          json['publishedAt'] == null ? '' : json['publishedAt'] as String,
      content: json['content'] == null ? '' : json['content'] as String,
    );
  }
}
