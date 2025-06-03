import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:flutter/material.dart';

@LazySingleton(as: CoutureRepository)
class CoutureRepositoryImpl implements CoutureRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CoutureRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Stream<List<Couture>> getCoutureStream() {
    debugPrint("🔄 Début de getCoutureStream()");

    return _firestore
        .collection('couture')
        .snapshots()
        .handleError((error) {
      debugPrint("❌ Erreur Firestore: $error");
      return <QuerySnapshot<Map<String, dynamic>>>[];
    })
        .asyncMap((querySnapshot) async {
      debugPrint("📊 Documents reçus: ${querySnapshot.docs.length}");

      if (querySnapshot.docs.isEmpty) {
        debugPrint("⚠️ Aucun document trouvé dans la collection 'couture'");
        return <Couture>[];
      }

      final coutures = await Future.wait(
        querySnapshot.docs.map((doc) async {
          try {
            debugPrint("📄 Traitement du document: ${doc.id}");
            final data = doc.data();
            debugPrint("📋 Données du document: $data");

            final couture = Couture.fromMap(data, doc.id);
            debugPrint("✅ Couture créée: ${couture.title}");

            // Récupération de l'image (optionnelle)
            final coutureWithImage = await _getImageForCouture(couture);
            return coutureWithImage;

          } catch (e, stackTrace) {
            debugPrint("❌ Erreur lors du traitement du document ${doc.id}: $e");
            debugPrint("📍 StackTrace: $stackTrace");

            // Retourner une couture basique en cas d'erreur
            try {
              return Couture.fromMap(doc.data(), doc.id);
            } catch (e2) {
              debugPrint("❌ Impossible de créer une couture basique: $e2");
              return null;
            }
          }
        }),
      );

      // Filtrer les éléments null
      final validCoutures = coutures.whereType<Couture>().toList();
      debugPrint("✅ Coutures valides retournées: ${validCoutures.length}");

      return validCoutures;
    });
  }

  // Méthode séparée pour la récupération d'images
  Future<Couture> _getImageForCouture(Couture couture) async {
    try {
      debugPrint("🖼️ Recherche d'image pour: ${couture.id}");

      final coutRef = _storage.ref().child('couture/${couture.id}');
      final ListResult result = await coutRef.listAll();

      debugPrint("📁 Fichiers trouvés: ${result.items.length}");

      String? imageUrl;
      for (Reference ref in result.items) {
        final String name = ref.name.toLowerCase();
        debugPrint("📎 Fichier: $name");

        if (name.endsWith('.jpg') ||
            name.endsWith('.jpeg') ||
            name.endsWith('.png') ||
            name.endsWith('.webp')) { // Ajout de .webp, suppression de .pdf
          imageUrl = await ref.getDownloadURL();
          debugPrint("🖼️ URL d'image trouvée: $imageUrl");
          break;
        }
      }

      if (imageUrl != null) {
        return Couture(
          id: couture.id,
          description: couture.description,
          price: couture.price,
          title: couture.title,
          imageUrl: imageUrl,
        );
      }

      debugPrint("⚠️ Aucune image trouvée pour: ${couture.id}");
      return couture;

    } catch (e) {
      debugPrint("❌ Erreur lors de la récupération d'image pour ${couture.id}: $e");
      return couture; // Retourner la couture sans image
    }
  }

  @override
  Future<void> add(CoutureDto coutureDto) async {
    try {
      debugPrint("➕ Ajout d'une nouvelle couture: ${coutureDto.id}");
      await _firestore
          .collection('couture')
          .doc(coutureDto.id)
          .set(coutureDto.toJson());
      debugPrint("✅ Couture ajoutée avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de l'ajout: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteCouture(String coutureId) async {
    try {
      debugPrint("🗑️ Suppression de la couture: $coutureId");

      // Supprimer le document Firestore
      await _firestore.collection('couture').doc(coutureId).delete();

      // Supprimer les fichiers Storage
      try {
        final result = await _storage.ref('couture/$coutureId').listAll();
        for (var ref in result.items) {
          await ref.delete();
        }
      } catch (storageError) {
        debugPrint("⚠️ Erreur lors de la suppression des fichiers: $storageError");
      }

      debugPrint("✅ Couture supprimée avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de la suppression: $e");
      rethrow;
    }
  }

  @override
  FirebaseStorage get storage => _storage;

  @override
  Future<CoutureDto?> getById(String coutureId) async {
    try {
      debugPrint("🔍 Recherche de la couture: $coutureId");

      final docSnapshot = await _firestore.collection('couture').doc(coutureId).get();

      if (!docSnapshot.exists) {
        debugPrint("❌ Document non trouvé: $coutureId");
        return null;
      }

      final data = docSnapshot.data()!;
      debugPrint("📋 Données trouvées: $data");

      // Récupération optionnelle de l'image
      try {
        final coutRef = _storage.ref().child('couture/$coutureId');
        final ListResult result = await coutRef.listAll();

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
        debugPrint('⚠️ Erreur Storage pour $coutureId: $storageError');
      }

      return CoutureDto.fromJson(data);
    } catch (e) {
      debugPrint("❌ Erreur lors de getById: $e");
      return null;
    }
  }

  @override
  Future<void> uploadField(String coutureId, String fieldName, newValue) async {
    try {
      debugPrint("📝 Mise à jour du champ $fieldName pour $coutureId");
      await _firestore.collection('couture').doc(coutureId).update({
        fieldName: newValue,
      });
      debugPrint("✅ Champ mis à jour avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de la mise à jour: $e");
      rethrow;
    }
  }
}