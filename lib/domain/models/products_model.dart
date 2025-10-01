
class ProductsModel {
    String id;
    String title;
    String subtitle;
    double price;
    String description;
    String categories;
    String image;
    String bgColor;

    ProductsModel({
        required this.id,
        required this.title,
      required this.subtitle,
        required this.price,
        required this.description,
        required this.categories,
        required this.image,
        required this.bgColor,
    });

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        title: json["title"],
        subtitle: json['subtitle'],
        price: json["price"]?.toDouble(),
        description: json["description"],
        categories: json['category'],
        image: json["image"],
        bgColor: json['bgColor'],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "categories": categories,
        "image": image,
        'bgColor': bgColor,
    };
}