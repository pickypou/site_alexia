class Couture {
  final String id;
  final String description;
  final String title;
  final String price; // Notez que c'est un String, pas un double
  String imageUrl; // Pas de valeur par défaut ici puisque c'est required dans le constructeur

  Couture({
    required this.id,
    required this.description,
    required this.price,
    required this.title,
    required this.imageUrl // Reste required
  });

  factory Couture.fromMap(Map<String, dynamic>? data, String id) {
    return Couture(
      id: id,
      description: data?['description'] ?? '',
      price: data?['price']?.toString() ?? '',
      title: data?['title'] ?? '',
      imageUrl: data?['imageUrl'] ?? '', // Utiliser la valeur de Firestore ou chaîne vide
    );
  }
}