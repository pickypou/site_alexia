abstract class BaseEntity {
  String get id;
  String get title;
  String get description;
  String get price;
  String get imageUrl;

  Map<String, dynamic> toMap();
}