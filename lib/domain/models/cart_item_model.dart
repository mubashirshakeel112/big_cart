class CartItemUIModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final double price;
  final String bgColor;
  final int quantity;

  CartItemUIModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.bgColor,
    required this.quantity,
  });

  CartItemUIModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? image,
    double? price,
    String? bgColor,
    int? quantity,
  }) {
    return CartItemUIModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      price: price ?? this.price,
      bgColor: bgColor ?? this.bgColor,
      quantity: quantity ?? this.quantity,
    );
  }
}
