

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';

@injectable
class RemoveCoutureInteractor {
  final FetchCoutureDataUseCase fetchCouture;
  final CoutureRepository repository;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;


  RemoveCoutureInteractor(this.fetchCouture, this.repository, this.firestore, this.storage);

  Future<List<Couture>> fetchCoutureData() async {
    try {
      final couture = await fetchCouture.getCouture();
      return couture;
    }catch (e) {
      debugPrint('Erreur lors de la récupération des objets couture : $e');
      rethrow;
    }
  }

  Future<Couture?> getCoutureById(String coutureId) async {
    try {
      return await fetchCouture.getCoutureById(coutureId);
    }catch (e) {
      debugPrint("Erreur lors de la récupération de l'objet couture par Id : $e");
      rethrow;
    }
  }



  Future<void> removeCouture(String coutureId, String imageUrl) async {
  try {
  debugPrint("🗑️ Suppression couture $coutureId");

  // Supprimer le document Firestore
  await firestore.collection('couture').doc(coutureId).delete();

  // Supprimer le fichier de Storage à partir de l'URL
  try {
  final ref = storage.refFromURL(imageUrl);
  await ref.delete();
  debugPrint("🧹 Image supprimée depuis Storage");
  } catch (e) {
  debugPrint("⚠️ Erreur suppression Storage : $e");
  }

  debugPrint("✅ Couture supprimée avec succès");
  } catch (e) {
  debugPrint("❌ Erreur générale suppression : $e");
  rethrow;
  }
  }
  }



