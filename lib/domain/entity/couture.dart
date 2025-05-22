

class Couture {
  final String id;
  final String text;
  final String title;
  final String imageUrl;

  Couture ({
    required this.id,
    required this.text,
    required this.title,
    required this.imageUrl
});

  factory Couture.formMap(Map<String, dynamic>? data, String id) {
    return Couture(
        id: id,
        text: data?['text'] ?? '',
        title: data?['title']?? '',
        imageUrl: data?['imageUrl']?? '',
    );
  }

}