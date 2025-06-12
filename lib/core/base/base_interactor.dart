import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/firestore_service.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/storage_service.dart';
import 'base_dto.dart';
import 'base_fetch_data_usecase.dart';




  class BaseInteractor<T extends BaseDto> {
    final BaseRepository<T> repository;
    final BaseFetchDataUsecase<T> usecase;
    final StorageService storage;
    final FirestoreService firestore;
    final T Function(Map<String, dynamic>, String) fromMap;
    final Future<T> Function(T, String) addImageToEntity;

    BaseInteractor({
      required this.usecase,
      required this.repository,
      required this.storage,
      required this.firestore,
      required this.fromMap,
      required this.addImageToEntity,
    });

    Future<List<T>> fetchData() async {
      debugPrint("🔄 Interactor: Début de fetchData");
      List<T> entityList = [];
      Set<String> seenEntityIds = {};

      try {
        debugPrint("📡 Interactor: Requête Firestore avec tri par ID...");
        QuerySnapshot snapshot = await firestore
            .collection(repository.collectionName)
            .get();

        debugPrint("📊 Interactor: ${snapshot.docs.length} documents trouvés");

        for (var doc in snapshot.docs) {
          try {
            debugPrint("📄 Interactor: Traitement du document ${doc.id}");
            final data = doc.data() as Map<String, dynamic>;
            debugPrint("📋 Données: $data");

            final entity = fromMap(data, doc.id);
            debugPrint("✅ Entité créée: ${entity.title}");

            if (seenEntityIds.contains(doc.id)) {
              debugPrint("⚠️ Entité déjà vue: ${entity.id}");
              continue;
            }
            seenEntityIds.add(doc.id);

            final entityWithImage = await addImageToEntity(entity, doc.id);
            entityList.add(entityWithImage);
          } catch (e, stackTrace) {
            debugPrint('❌ Erreur de parsing du document ${doc.id}: $e');
            debugPrint('📍 StackTrace: $stackTrace');
          }
        }

        debugPrint("✅ Interactor: ${entityList.length} entités récupérées");
      } catch (e, stackTrace) {
        debugPrint('❌ Erreur lors de la récupération : $e');
        debugPrint('📍 StackTrace: $stackTrace');
        rethrow;
      }

      return entityList;
    }


    Future<String> uploadFile(Uint8List fileBytes, String id,
        {String? fileExtension}) async {
      try {
        // Déterminer l'extension
        final extension = fileExtension ?? 'jpg';
        final path = 'couture/$id.$extension';

        debugPrint("📤 Upload de l'image: $path");

        // L'upload inclura automatiquement le bon contentType
        return await storage.uploadFileBytes(path, fileBytes);
      } catch (e) {
        debugPrint("❌ Erreur lors de l'upload du fichier couture : $e");
        rethrow;
      }
    }

// Méthode pour corriger les fichiers existants
    Future<void> fixExistingImageContentTypes() async {
      try {
        debugPrint("🔧 Correction des types MIME des images de couture...");
        await storage.fixContentTypesInFolder('couture');
        debugPrint("✅ Correction terminée");
      } catch (e) {
        debugPrint("❌ Erreur lors de la correction: $e");
      }
    }

    Future<void> add(T entity) async {
      try {
        await firestore
            .collection(repository.collectionName)
            .doc(entity.id)
            .set(entity.toMap());
      } catch (e) {
        debugPrint("Erreur lors de l'ajout de l'objet : $e");
        throw Exception("Erreur lors de l'ajout de l'objet : $e");
      }
    }



    Future<T?> getById(String entityId) async {
      try {
        final doc = await firestore.collection(repository.collectionName).doc(entityId).get();
        if (doc.exists) {
          return fromMap(doc.data() as Map<String, dynamic>, doc.id);
        } else {
          debugPrint("🔍 Aucun document trouvé pour l'ID : $entityId");
          return null;
        }
      } catch (e) {
        debugPrint("❌ Erreur lors de la récupération de l'objet par ID : $e");
        rethrow;
      }
    }



    Future<void> delete(String entityId, String imageUrl) async {
      try {
        debugPrint("🗑️ Suppression de l'entité $entityId");

        // Supprimer le document Firestore
        await firestore.collection(repository.collectionName).doc(entityId).delete();
        debugPrint("📄 Document Firestore supprimé");

        // Supprimer le fichier de Storage à partir de l'URL
        try {
          await storage.deleteImageByUrl(imageUrl);
          debugPrint("🧹 Fichier supprimé depuis le stockage");
        } catch (e) {
          debugPrint("⚠️ Erreur lors de la suppression du fichier dans le stockage : $e");
        }

        debugPrint("✅ Entité supprimée avec succès");
      } catch (e) {
        debugPrint("❌ Erreur générale lors de la suppression : $e");
        rethrow;
      }
    }

  }





