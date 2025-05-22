

class CoutureDto {
  final String id;
  final String title;
  final String text;
  final String imageUrl;

  CoutureDto({
    required this.id,
    required this.title,
    required this.text,
    required this.imageUrl
});
  factory CoutureDto.fromJson(Map<String, dynamic> json) {
    return CoutureDto(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        imageUrl: json['imageUrl']
    );
  }

  Map<String, dynamic>toJson(){
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl
    };
  }

  @override
  String toString(){
    return
        'CoutureDto{id:$id, title: $title, text:$text, imageUrl:$imageUrl}';
  }
}
