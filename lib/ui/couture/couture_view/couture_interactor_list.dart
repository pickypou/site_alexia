import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';

class CoutureInteractorList {
  final FetchCoutureDataUseCase fetchCoutureDataUseCase = getIt<FetchCoutureDataUseCase>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Couture>> fetchCouture() async {
    debugPrint("🔄 Interactor: Début de fetchCouture");
    List<Couture> coutureList = [];
    Set<String> seenCoutureIds = {};

    try {
      debugPrint("📡 Interactor: Requête Firestore avec tri par ID...");

      // Tri par ID décroissant (plus récent en premier)
      QuerySnapshot snapshot = await _firestore
          .collection('couture')
          .get();

      debugPrint("📊 Interactor: ${snapshot.docs.length} documents trouvés");

      for (var doc in snapshot.docs) {
        try {
          debugPrint("📄 Interactor: Traitement du document ${doc.id}");
          final data = doc.data() as Map<String, dynamic>;
          debugPrint("📋 Données: $data");

          final couture = Couture.fromMap(data, doc.id);
          debugPrint("✅ Couture créée: ${couture.title}");

          if (seenCoutureIds.contains(couture.id)) {
            debugPrint("⚠️ Couture déjà vue: ${couture.id}");
            continue;
          }
          seenCoutureIds.add(couture.id);

          // Récupération de l'image
          Couture coutureWithImage = await _getCoutureWithImage(couture);
          coutureList.add(coutureWithImage);

        } catch (e, stackTrace) {
          debugPrint('❌ Erreur de parsing du document ${doc.id}: $e');
          debugPrint('📍 StackTrace: $stackTrace');
        }
      }

      debugPrint("✅ Interactor: ${coutureList.length} coutures récupérées");
    } catch (e, stackTrace) {
      debugPrint('❌ Erreur lors de la récupération des coutures: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      rethrow;
    }

    return coutureList;
  }

  Future<Couture> _getCoutureWithImage(Couture couture) async {
    try {
      debugPrint("🖼️ Recherche d'image pour: ${couture.id}");

      // Si l'imageUrl existe déjà dans les données Firestore, la valider
      if (couture.imageUrl.isNotEmpty) {
        debugPrint("📋 URL existante trouvée: ${couture.imageUrl}");

        // Vérifier si l'URL est valide
        if (couture.imageUrl.contains('firebasestorage.googleapis.com') &&
            !couture.imageUrl.contains('<!DOCTYPE')) {
          debugPrint("✅ URL d'image valide trouvée");
          return couture;
        } else {
          debugPrint("❌ URL d'image corrompue, recherche d'une nouvelle...");
        }
      }

      // Rechercher l'image dans Storage
      String imageUrl = ''; // Initialiser avec chaîne vide

      try {
        // Essayer le nom de fichier basé sur l'ID
        final imageRef = _storage.ref().child('couture/${couture.id}.jpg');
        imageUrl = await imageRef.getDownloadURL();
        debugPrint("✅ Image trouvée: ${couture.id}.jpg");
      } catch (e) {
        debugPrint("⚠️ ${couture.id}.jpg non trouvé, recherche dans le dossier...");

        try {
          // Lister tous les fichiers dans le dossier
          final folderRef = _storage.ref().child('couture/${couture.id}');
          final listResult = await folderRef.listAll();

          debugPrint("📁 ${listResult.items.length} fichiers trouvés");

          for (var item in listResult.items) {
            final name = item.name.toLowerCase();
            debugPrint("📎 Fichier trouvé: ${item.name}");

            if (name.endsWith('.jpg') || name.endsWith('.jpeg') || name.endsWith('.png')) {
              imageUrl = await item.getDownloadURL();
              debugPrint("✅ Image trouvée: ${item.name}");
              break;
            }
          }
        } catch (e2) {
          debugPrint("⚠️ Erreur lors de la recherche dans le dossier: $e2");
        }
      }

      if (imageUrl.isNotEmpty) {
        debugPrint("🖼️ URL finale: $imageUrl");

        return Couture(
          id: couture.id,
          title: couture.title,
          description: couture.description,
          price: couture.price,
          imageUrl: imageUrl,
        );
      }

      debugPrint("⚠️ Aucune image valide trouvée pour: ${couture.id}");
      return Couture(
        id: couture.id,
        title: couture.title,
        description: couture.description,
        price: couture.price,
        imageUrl: '', // Chaîne vide au lieu de null
      );

    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération d\'image pour ${couture.id}: $e');
      return couture;
    }
  }

  Widget _buildImageWidget(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint("❌ Erreur de chargement d'image: $error");
          debugPrint("🔗 URL problématique: $imageUrl");

          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Icon(
              Icons.broken_image,
              color: Colors.red.shade600,
              size: 24,
            ),
          );
        },
      ),
    );
  }

  Future<Couture?> fetchCoutureById(String coutureId) async {
    try {
      debugPrint("🔍 Recherche de la couture: $coutureId");
      return await fetchCoutureDataUseCase.getCoutureById(coutureId);
    } catch (e) {
      debugPrint('❌ Erreur lors de la récupération de couture spécifique: $e');
      rethrow;
    }
  }

  Stream<List<Couture>> getCoutureStream() {
    debugPrint("📡 Interactor: Création du stream avec tri par ID");

    return _firestore
        .collection('couture')
        .orderBy(FieldPath.documentId, descending: true) // Tri par ID décroissant
        .snapshots()
        .handleError((error) {
      debugPrint("❌ Erreur dans le stream Firestore: $error");
    })
        .asyncMap((snapshot) async {
      debugPrint("📊 Stream: ${snapshot.docs.length} documents reçus");
      List<Couture> list = [];

      for (var doc in snapshot.docs) {
        try {
          debugPrint("📄 Stream: Traitement du document ${doc.id}");
          final couture = Couture.fromMap(doc.data(), doc.id);

          // Récupération de l'image
          final coutureWithImage = await _getCoutureWithImage(couture);
          list.add(coutureWithImage);

        } catch (e) {
          debugPrint("❌ Erreur de parsing couture stream ${doc.id}: $e");
        }
      }

      debugPrint("✅ Stream: ${list.length} coutures retournées");
      return list;
    });
  }

  // Méthode pour nettoyer les URLs corrompues (optionnelle)
  Future<void> cleanCorruptedImageUrls() async {
    debugPrint("🧹 Nettoyage des URLs d'images corrompues...");

    try {
      final snapshot = await _firestore.collection('couture').get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final imageUrl = data['imageUrl'] as String?;

        if (imageUrl != null &&
            (imageUrl.contains('<!DOCTYPE') || !imageUrl.contains('firebasestorage.googleapis.com'))) {
          debugPrint("🧹 Suppression de l'URL corrompue pour ${doc.id}");

          await doc.reference.update({
            'imageUrl': FieldValue.delete(),
          });

          debugPrint("✅ URL corrompue supprimée pour ${doc.id}");
        }
      }

      debugPrint("✅ Nettoyage terminé");
    } catch (e) {
      debugPrint("❌ Erreur lors du nettoyage: $e");
    }
  }
}