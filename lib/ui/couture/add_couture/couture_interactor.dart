import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/firestore_service.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/storage_service.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';
import '../../../data/repository/couture_repository.dart';

@injectable
class CoutureInteractor {
  final CoutureRepository coutureRepository;
  final FetchCoutureDataUseCase fetchCoutureDataUseCase;
  final StorageService storageService;
  final FirestoreService firestoreService;

  CoutureInteractor({
      required this.fetchCoutureDataUseCase,
        required this.coutureRepository,
        required this.storageService,
        required this.firestoreService,
      });

  Future<Iterable<Couture>> fetchCoutureData() async {
    try {
      return await fetchCoutureDataUseCase.getCouture();
    } catch (e) {
      debugPrint("Erreur lors de la récupération de couture : $e");
      rethrow;
    }
  }

  Future<String> uploadCoutureFile(Uint8List fileBytes, String id, {String? fileExtension}) async {
    try {
      // Déterminer l'extension
      final extension = fileExtension ?? 'jpg';
      final path = 'couture/$id.$extension';

      debugPrint("📤 Upload de l'image: $path");

      // L'upload inclura automatiquement le bon contentType
      return await storageService.uploadFileBytes(path, fileBytes);
    } catch (e) {
      debugPrint("❌ Erreur lors de l'upload du fichier couture : $e");
      rethrow;
    }
  }

// Méthode pour corriger les fichiers existants
  Future<void> fixExistingImageContentTypes() async {
    try {
      debugPrint("🔧 Correction des types MIME des images de couture...");
      await storageService.fixContentTypesInFolder('couture');
      debugPrint("✅ Correction terminée");
    } catch (e) {
      debugPrint("❌ Erreur lors de la correction: $e");
    }
  }
  Future<void> addCouture(Couture couture) async {
    try {
      await firestoreService.collection('couture').doc(couture.id).set({
        'title': couture.title,
        'description': couture.description,
        'price': couture.price,
        'imageUrl': couture.imageUrl,
      });
    } catch (e) {
      debugPrint("Erreur lors de l'ajout de l'objet couture : $e");
      throw Exception("Erreur lors de l'ajout de l'objet couture : $e");
    }
  }
}
