// CoutureDto
import '../../core/base/generic_dto.dart';

class CoutureDto extends GenericDto {
  CoutureDto({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  factory CoutureDto.fromJson(Map<String, dynamic> json) {
    return CoutureDto(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] ?? 0).toString(), // Convertir en String pour correspondre au type parent
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  CoutureDto copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? imageUrl,
  }) {
    return CoutureDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}