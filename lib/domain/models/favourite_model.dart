class FavouriteModel {
  String id;
  DateTime createdAt;

  FavouriteModel({
    required this.id,
    required this.createdAt
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String()
    };
  }
}
