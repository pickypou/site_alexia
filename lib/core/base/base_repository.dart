import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_dto.dart';
import 'package:flutter/material.dart';

import '../../data/dto/couture_dto.dart';


class BaseRepository <T extends BaseDto> {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final String _collectionName;
  final T Function(Map<String, dynamic>, String) _fromMap;
  final T Function(T entity, String imageUrl) _addImageToEntity;

 BaseRepository({
    required String collectionName,
   required T Function(Map<String, dynamic>, String) fromMap,
   required T Function(T, String) addImageToEntity,
   FirebaseFirestore? firestore,
   FirebaseStorage? storage,
}) : _collectionName = collectionName,
       _fromMap = fromMap,
       _addImageToEntity = addImageToEntity,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  // ✅ Getters publics
  String get collectionName => _collectionName;
  T Function(Map<String, dynamic>, String) get fromMap => _fromMap;
  T Function(T, String) get addImageToEntity => _addImageToEntity;

  Stream<List<T>> getStream<T>({
    required String collectionName,
    required T Function(Map<String, dynamic> data, String id) fromMap,
    Future<T> Function(T entity)? withImage,
  }) {
    debugPrint("🔄 Début de getStream()");

    return _firestore.collection(collectionName).snapshots().asyncMap((snapshot) async {
      debugPrint("📊 Documents reçus: ${snapshot.docs.length}");

      if (snapshot.docs.isEmpty) {
        debugPrint("⚠️ Aucun document trouvé dans la collection");
        return <T>[];
      }

      final entities = await Future.wait(snapshot.docs.map((doc) async {
        try {
          debugPrint("📄 Traitement du document: ${doc.id}");
          final data = doc.data() as Map<String, dynamic>;
          debugPrint("📋 Données du document: $data");

          T entity = fromMap(data, doc.id);
          debugPrint("✅ Entité créée: ${doc.id}");

          if (withImage != null) {
            entity = await withImage(entity);
          }

          return entity;
        } catch (e, stack) {
          debugPrint("❌ Erreur lors du traitement du document ${doc.id}: $e");
          debugPrint("📍 Stack: $stack");
          return null;
        }
      }));

      final validEntities = entities.whereType<T>().toList();
      debugPrint("✅ Entités valides: ${validEntities.length}");
      for (var e in validEntities) {
        debugPrint("➡️ ${(e as dynamic).id}");
      }

      return validEntities;
    });
  }



  // Méthode séparée pour la récupération d'images
  Future<T> _getImageForEntity(T entity) async {
    try {
      debugPrint("🖼️ Recherche d'image pour: ${entity.id}");

      final entityRef = _storage.ref().child('couture/${entity.id}');
      final ListResult result = await entityRef.listAll();

      debugPrint("📁 Fichiers trouvés: ${result.items.length}");

      for (Reference ref in result.items) {
        final String name = ref.name.toLowerCase();
        debugPrint("📎 Fichier: $name");

        if (name.endsWith('.jpg') ||
            name.endsWith('.jpeg') ||
            name.endsWith('.png') ||
            name.endsWith('.webp')) {
          final imageUrl = await ref.getDownloadURL();
          debugPrint("🖼️ URL d'image trouvée: $imageUrl");

          return _addImageToEntity(entity, imageUrl); // ✅
        }
      }

      debugPrint("⚠️ Aucune image trouvée pour: ${entity.id}");
      return entity;
    } catch (e) {
      debugPrint("❌ Erreur lors de la récupération d'image pour ${entity.id}: $e");
      return entity;
    }
  }



  Future<void> add<D extends BaseDto>(D dto) async {
    try {
      debugPrint("➕ Ajout d'un nouvel élément: ${dto.id}");
      await _firestore
      .collection(_collectionName)
      .doc(dto.id)
      .set(dto.toJson());
      debugPrint("✅ Élément ajouté avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de l'ajout: $e");
      rethrow;
    }
  }


  Future<void> delete(String entityId) async {
    if (entityId.isEmpty) {
      debugPrint("❌ entityId est vide, suppression annulée.");
      return;
    }

    try {
      debugPrint("🗑️ Suppression de l'entité : $entityId");

      // Supprimer le document Firestore
      await _firestore.collection(_collectionName).doc(entityId).delete();

      // Supprimer le fichier Storage correspondant (directement)
      try {
        final fileRef = _storage.ref("$_collectionName/$entityId");
        await fileRef.delete();
        debugPrint("Fichier Storage supprimé: $_collectionName/$entityId");
      } catch (storageError) {
        debugPrint("⚠️ Erreur lors de la suppression du fichier Storage: $storageError");
      }

      debugPrint("✅ Entité supprimée avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de la suppression: $e");
      rethrow;
    }
  }




  FirebaseStorage get storage => _storage;


  Future<D?> getById<D extends BaseDto>(
      String entityId,
      D Function(Map<String, dynamic>) fromJson,
      ) async {
    try {
      debugPrint("🔍 Recherche des Items: $entityId");

      final docSnapshot = await _firestore.collection(_collectionName).doc(entityId).get();

      if (!docSnapshot.exists) {
        debugPrint("❌ Document non trouvé: $entityId");
        return null;
      }

      final data = docSnapshot.data()!;
      debugPrint("📋 Données trouvées: $data");

      // Récupération optionnelle de l'image
      try {
        final entityRef = _storage.ref().child('$_collectionName/$entityId');
        final ListResult result = await entityRef.listAll();

        String? imageUrl;
        for (Reference ref in result.items) {
          final String name = ref.name.toLowerCase();
          if (name.endsWith('.jpg') ||
              name.endsWith('.jpeg') ||
              name.endsWith('.png') ||
              name.endsWith('.webp')) {
            imageUrl = await ref.getDownloadURL();
            break;
          }
        }

        if (imageUrl != null) {
          data['imageUrl'] = imageUrl;
        }
      } catch (storageError) {
        debugPrint('⚠️ Erreur Storage pour $entityId: $storageError');
      }

      return fromJson(data);
    } catch (e) {
      debugPrint("❌ Erreur lors de getById: $e");
      return null;
    }
  }



  Future<void> uploadField(String entityId, String fieldName, newValue) async {
    try {
      debugPrint("📝 Mise à jour du champ $fieldName pour $entityId");
      await _firestore.collection(_collectionName).doc(entityId).update({
        fieldName: newValue,
      });
      debugPrint("✅ Champ mis à jour avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de la mise à jour: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getRawDataById(String id) async {
    try {
      final snapshot = await _firestore.collection(_collectionName).doc(id).get();
      if (snapshot.exists) {
        return snapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('❌ Firestore getById error: $e');
      rethrow;
    }
  }

}