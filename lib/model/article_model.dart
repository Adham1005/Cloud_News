class ArticleModel {
  String title;
  String? subTitle;
  String? image;
  String? url;

  ArticleModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': subTitle,
      'image_url': image,
      'link': url,
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      subTitle: json['description'],
      image: json['image_url'],
      url: json['link'],
    );
  }
}
