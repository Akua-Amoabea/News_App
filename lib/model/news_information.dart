class NewsInformation {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsInformation({this.status, this.totalResults, this.articles});

  NewsInformation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        //print('the item is : $v');
        //print(articles);
        articles!.add( Articles.fromJson(v));
        //print(' the articles list : ${Articles.fromJson(v)}');
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }/*
  @override
  String toString() {
    return 'status: $status, totalResults: $totalResults, Articles: \n$Articles: \n${articles?.map((article) => article.toString()).join('\n\n')}';
  }*/
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles({this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }


/*  @override
  String toString() {
    return 'name: ${source?.name} \n'
    'id: ${source?.id}'
        'Author: $author\n'
        'Title: $title\n'
        'Description: $description\n'
        'URL: $url\n'
        'Image URL: $urlToImage\n'
        'Published At: $publishedAt\n'
        'Content: $content';
  }*/

}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  /*@override
  String toString() {
    return 'id: $id, name: $name ';
  }*/


}