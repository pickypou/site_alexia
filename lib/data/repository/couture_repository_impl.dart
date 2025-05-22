import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:flutter/material.dart';

@injectable
class CoutureRepositoryImpl implements CoutureRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CoutureRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  @override
  Stream<Iterable<Couture>> getCoutureStream() {
    return _firestore.collection('couture').snapshots().asyncMap((
      querySnapshot,
    ) async {
      final couture = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final data = doc.data();
          final couture = Couture.formMap(data, doc.id);

          try {
            final coutRef = _storage.ref().child('couture/${couture.id}');
            debugPrint("Traitement des données couture : ${couture.id}");

            //Lister tous les fichiers dans le dossier couture
            final ListResult result = await coutRef.listAll();

            String? imageUrl;

            //chercher le fichier principal
            for (Reference ref in result.items) {
              final String name = ref.name.toLowerCase();
              if (name.endsWith('.jpg') ||
                  name.endsWith('.jpeg') ||
                  name.endsWith('.png') ||
                  name.endsWith('.pdf')) {
                imageUrl = await ref.getDownloadURL();
                break;
              }
            }
            if (imageUrl != null) {
              return Couture(
                id: couture.id,
                text: couture.text,
                title: couture.title,
                imageUrl: imageUrl,
              );
            }
            return couture;
          } catch (e) {
            debugPrint(
              "Errur lors de  la récupération des fichier pour couture ${couture.id}: $e",
            );
            return couture;
          }
        }),
      );
      return couture;
    });
  }

  @override
  Future<void> add(CoutureDto coutureDto) async {
    await _firestore
        .collection('couture')
        .doc(coutureDto.id)
        .set(coutureDto.toJson());
  }

  @override
  Future<void> deleteCouture(String coutureId) async {
    await _firestore.collection('couture').doc(coutureId).delete();
    await _storage.ref('couture/$coutureId').listAll().then((result) {
      for (var ref in result.items) {
        ref.delete();
      }
    });
  }

  @override
  // TODO: implement firestore
  FirebaseStorage get firestore => throw UnimplementedError();

  @override
  Future<CoutureDto?> getById(String coutureId) async {
    final docSnapshot =
        await _firestore.collection('couture').doc(coutureId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      final coutRef = _storage.ref().child('couture/$coutureId');

      try {
        final ListResult result = await coutRef.listAll();

        String? imageUrl;
        for (Reference ref in result.items) {
          final String name = ref.name.toLowerCase();
          if (name.endsWith('.jpg') ||
              name.endsWith('.jpeg') ||
              name.endsWith('.png') ||
              name.endsWith('.pdf')) {
            imageUrl = await ref.getDownloadURL();
            break;
          }
        }
        if (imageUrl != null) {
          data['imageUrl'] = imageUrl;
        }
      } catch (e) {
        debugPrint('Erreur lors de la récupération des données $coutureId: $e');
      }
      return CoutureDto.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> uploadField(String coutureId, String fieldName, newValue) async {
    await _firestore.collection('couture').doc(coutureId).update({
      fieldName: newValue,
    });
  }
}
