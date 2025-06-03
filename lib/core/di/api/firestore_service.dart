import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@injectable
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(
      this._firestore
      );
  CollectionReference collection(String path) {
    return _firestore.collection(path);
  }

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
    } catch (e) {
      debugPrint('Erreur lors de l\'ajout de données : $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des données : $e');
      rethrow;
    }
  }

}