import '../../core/base/generic_dto.dart';

class CoutureDto extends GenericDto {
  CoutureDto({
    required String id,
    required String title,
    required String description,
    required String price,
    required String imageUrl,
  }) : super(
    id: id,
    title: title,
    description: description,
    price: price,
    imageUrl: imageUrl,
  );

  factory CoutureDto.fromJson(Map<String, dynamic> json) {
    return CoutureDto(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] ?? 0).toString(),
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
