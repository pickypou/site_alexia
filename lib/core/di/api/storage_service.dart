import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageService {
  final FirebaseStorage _firebaseStorage;

  StorageService(this._firebaseStorage);

  Reference ref(String path) {
    return _firebaseStorage.ref(path);
  }

  // Getter pour accéder à l'instance FirebaseStorage
  FirebaseStorage get storage => _firebaseStorage;

  // Version améliorée avec contentType
  Future<String> uploadFileBytes(String path, Uint8List fileBytes, {String? contentType}) async {
    try {
      final ref = _firebaseStorage.ref(path);

      // Déterminer le contentType automatiquement si non fourni
      final finalContentType = contentType ?? _getContentTypeFromPath(path);

      debugPrint("📤 Upload vers: $path");
      debugPrint("🏷️ ContentType: $finalContentType");

      // Upload avec métadonnées incluant le contentType
      final uploadTask = ref.putData(
        fileBytes,
        SettableMetadata(
          contentType: finalContentType,
          customMetadata: {
            'uploaded_at': DateTime.now().toIso8601String(),
            'uploaded_from': 'flutter_web',
          },
        ),
      );

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint("✅ Upload réussi!");
      debugPrint("🔗 URL: $downloadUrl");

      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Erreur lors de l\'upload: $e');
      rethrow;
    }
  }

  // Version avec File (pour mobile)
  Future<String> uploadFile(String path, File file, {String? contentType}) async {
    try {
      final ref = _firebaseStorage.ref(path);

      // Déterminer le contentType
      final finalContentType = contentType ?? _getContentTypeFromPath(path);

      debugPrint("📤 Upload fichier vers: $path");
      debugPrint("🏷️ ContentType: $finalContentType");

      final uploadTask = ref.putFile(
        file,
        SettableMetadata(
          contentType: finalContentType,
          customMetadata: {
            'uploaded_at': DateTime.now().toIso8601String(),
            'uploaded_from': 'flutter_mobile',
          },
        ),
      );

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint("✅ Upload fichier réussi!");
      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Erreur lors de l\'upload du fichier: $e');
      rethrow;
    }
  }

  Future<void> deleteImageByUrl(String imageUrl) async {
    try {
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
      debugPrint("✅ Image supprimée avec succès");
    } catch (e) {
      debugPrint("❌ Erreur lors de la suppression de l'image : $e");
      rethrow;
    }
  }



  Future<String> downloadUrl(String path) async {
    try {
      final ref = _firebaseStorage.ref(path);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération de l\'URL: $e');
      rethrow;
    }
  }

  // Méthode pour obtenir les métadonnées d'un fichier
  Future<FullMetadata> getMetadata(String path) async {
    try {
      final ref = _firebaseStorage.ref(path);
      return await ref.getMetadata();
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération des métadonnées: $e');
      rethrow;
    }
  }

  // Méthode pour mettre à jour les métadonnées
  Future<void> updateMetadata(String path, SettableMetadata metadata) async {
    try {
      final ref = _firebaseStorage.ref(path);
      await ref.updateMetadata(metadata);
      debugPrint("✅ Métadonnées mises à jour pour: $path");
    } catch (e) {
      debugPrint('❌ Erreur lors de la mise à jour des métadonnées: $e');
      rethrow;
    }
  }

  // Méthode pour lister les fichiers dans un dossier
  Future<ListResult> listFiles(String path) async {
    try {
      final ref = _firebaseStorage.ref(path);
      return await ref.listAll();
    } catch (e) {
      debugPrint('❌ Erreur lors de la liste des fichiers: $e');
      rethrow;
    }
  }

  // Méthode pour supprimer un fichier
  Future<void> deleteFile(String path) async {
    try {
      final ref = _firebaseStorage.ref(path);
      await ref.delete();
      debugPrint("✅ Fichier supprimé: $path");
    } catch (e) {
      debugPrint('❌ Erreur lors de la suppression: $e');
      rethrow;
    }
  }

  // Méthode privée pour déterminer le contentType basé sur l'extension
  String _getContentTypeFromPath(String path) {
    final extension = path.split('.').last.toLowerCase();

    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'bmp':
        return 'image/bmp';
      case 'svg':
        return 'image/svg+xml';
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      case 'json':
        return 'application/json';
      default:
        debugPrint("⚠️ Extension inconnue: $extension, utilisation de image/jpeg par défaut");
        return 'image/jpeg'; // Par défaut pour les images
    }
  }

  // Méthode pour corriger les types MIME des fichiers existants
  Future<void> fixContentTypesInFolder(String folderPath) async {
    try {
      debugPrint("🔧 Correction des types MIME dans: $folderPath");

      final listResult = await listFiles(folderPath);

      // Traiter les fichiers directs
      for (var item in listResult.items) {
        await _fixSingleFileContentType(item);
      }

      // Traiter les sous-dossiers
      for (var prefix in listResult.prefixes) {
        final subListResult = await prefix.listAll();
        for (var item in subListResult.items) {
          await _fixSingleFileContentType(item);
        }
      }

      debugPrint("✅ Correction des types MIME terminée");
    } catch (e) {
      debugPrint("❌ Erreur lors de la correction des types MIME: $e");
    }
  }

  Future<void> _fixSingleFileContentType(Reference fileRef) async {
    try {
      final expectedContentType = _getContentTypeFromPath(fileRef.name);

      // Vérifier le type actuel
      final metadata = await fileRef.getMetadata();

      if (metadata.contentType != expectedContentType) {
        debugPrint("🔧 Correction: ${fileRef.fullPath}");
        debugPrint("   ${metadata.contentType} → $expectedContentType");

        // Mettre à jour les métadonnées
        await fileRef.updateMetadata(
          SettableMetadata(contentType: expectedContentType),
        );

        debugPrint("✅ Type MIME corrigé pour: ${fileRef.name}");
      } else {
        debugPrint("✅ Type MIME déjà correct pour: ${fileRef.name}");
      }
    } catch (e) {
      debugPrint("❌ Erreur lors de la correction de ${fileRef.name}: $e");
    }
  }
}