abstract class Mappable {
  Map<String, dynamic> toMap();
}

abstract class BaseDto extends Mappable {
  String get id;
  String get title;
  String get description;
  String get price;
  String get imageUrl;
  Map<String, dynamic> toJson();
}
