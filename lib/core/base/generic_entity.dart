import 'base_entity.dart';

abstract class GenericEntity extends BaseEntity {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String price;
  @override
  final String imageUrl;

  GenericEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
  };
}
