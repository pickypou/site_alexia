

class CoutureDto {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  CoutureDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl
  });
  factory CoutureDto.fromJson(Map<String, dynamic> json) {
    return CoutureDto(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl
    };
  }

  @override
  String toString(){
    return
      'CoutureDto{id:$id, title: $title, description:$description, price:$price, imageUrl:$imageUrl}';
  }
}