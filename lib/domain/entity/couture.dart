// Couture
import '../../core/base/generic_entity.dart';

class Couture extends GenericEntity {
  Couture({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  static Couture fromMap(Map<String, dynamic> json, String id) {
    return Couture(
      id: id,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] ?? 0).toString(), // Convertir en String
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}