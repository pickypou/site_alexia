import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_dto.dart';
import 'package:flutter/material.dart';


class BaseFetchDataUsecase<T extends BaseDto> {
  final BaseRepository<T> _repository;
  final T Function(Map<String, dynamic>, String) _fromMap;

  BaseFetchDataUsecase({
    required BaseRepository<T> repository,
    required T Function(Map<String, dynamic>, String) fromMap,
  })
      : _repository = repository,
        _fromMap = fromMap;


  ///Méthode pour récupérer tous les objet d'une entité
  Future<List<T>> getStream() async {
    try {
      debugPrint('Fetching  data from Firestore...');
      final data = await _repository
          .getStream()
          .first;
      return data;
    } catch (e) {
      debugPrint('Error fetching couture data: $e');
      rethrow;
    }
  }

  ///Méthode de récupérer un objet couture via son ID
  Future<T?> getById(String entityId) async {
    try {
      debugPrint('📥 Fetching object by ID: $entityId');
      final rawData = await _repository.getRawDataById(entityId);
      if (rawData != null) {
        final dto = _fromMap(rawData, entityId);
        debugPrint('✅ DTO créé : $dto');
        return dto;
      } else {
        debugPrint('⚠️ No data found for ID: $entityId');
        return null;
      }
    } catch (e) {
      debugPrint('❌ Error fetching by ID: $e');
      rethrow;
    }
  }
}

