class CartModel {
  final String id;
  final int quantity;
  final DateTime createdAt;

  CartModel({
    required this.id,
    required this.quantity,
    required this.createdAt,
  });

  CartModel copyWith({
    String? id,
    int? quantity,
    DateTime? createdAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      quantity: json['quantity'] ,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
