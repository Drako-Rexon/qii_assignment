class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: List.generate(json['articles'].length,
            (index) => Article.fromJson(json['articles'][index])));
  }
}

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
        author: json['author'] ?? "No Author",
        title: json['title'],
        description: json['description'] ?? "Empty Description",
        url: json['url'],
        urlToImage: json['urlToImage'] ?? "",
        publishedAt: json['publishedAt'],
        content: json['content'] ?? "Empty content");
  }
}

class Source {
  dynamic id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
