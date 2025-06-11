abstract class BaseDto {
  String get id;
  String get title;
  String get description;
  String get price;
  String get imageUrl;
  Map<String, dynamic> toJson();
}
