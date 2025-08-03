import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

class Welcome {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;

  final String price;
  final String description;
  final String title;

  Welcome({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
    required this.description,
    required this.title,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        oldPrice: json["oldPrice"],
        price: json["price"],
        description: json["description"],
        title: json["title"],
      );
}
