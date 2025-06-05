import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EntityDownloadService {
  final FirebaseFirestore firestore;

  EntityDownloadService(this.firestore);

  /// Récupère toutes les entités d'une collection Firestore et les convertit en objets via [fromMap].
  Future<List<T>> fetchEntities<T>({
    required String collection,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final querySnapshot = await firestore.collection(collection).get();

      final List<T> entities = querySnapshot.docs
          .map((doc) => fromMap(doc.data()))
          .toList();

      return entities;
    } catch (e) {
      debugPrint('Erreur lors du téléchargement des entités depuis $collection : $e');
      rethrow;
    }
  }
}
