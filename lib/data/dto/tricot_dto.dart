import '../../../core/base/generic_dto.dart';

class TricotDto extends GenericDto {
  TricotDto({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.imageUrl,
  });

  factory TricotDto.fromJson(Map<String, dynamic> json) {
    return TricotDto(
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

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  TricotDto copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? imageUrl,
  }) {
    return TricotDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }


}