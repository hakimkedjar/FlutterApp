class Article {
  final String title;
  final String description;
  final int price;

  Article(
      {required this.title, required this.description, required this.price});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      price: json['price'],
    );
  }
}
