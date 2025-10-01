class OrderModel {
  final String id;
  final String userId;
  final String userName;
  final String phoneNumber;
  final String email;
  final Map<String, dynamic> address;
  final List<Items> items;
  final double totalPrice;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.items,
    required this.totalPrice,
    required this.paymentMethod,
    this.status = "pending",
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "userName": userName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "items": items.map((item) => item.toMap()).toList(),
      "totalPrice": totalPrice,
      "paymentMethod": paymentMethod,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }


  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map["id"],
      userId: map["userId"],
      userName: map["userName"],
      phoneNumber: map["phoneNumber"],
      email: map['email'],
      address: Map<String, dynamic>.from(map["address"]),
      items: (map["items"] as List)
          .map((item) => Items.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      totalPrice: map["totalPrice"].toDouble(),
      paymentMethod: map["paymentMethod"],
      status: map["status"],
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}

class Items {
  String id;
  String title;
  int quantity;
  double price;

  Items({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }
}
