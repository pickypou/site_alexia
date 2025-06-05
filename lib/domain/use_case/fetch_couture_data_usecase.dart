import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:flutter/material.dart';

import '../../data/repository/couture_repository.dart';

@injectable
class FetchCoutureDataUseCase {
  final CoutureRepository _repository;

  FetchCoutureDataUseCase(this._repository);

  ///Méthode pour récupérer tous les objet couture
  Future<List<Couture>> getCouture() async {
    try {
      debugPrint('Fetching couture data from Firestore...');
      final coutureIterable = await _repository.getCoutureStream().first;
      return coutureIterable.toList();
    } catch (e) {
      debugPrint('Error fetching couture data: $e');
      rethrow;
    }
  }
  ///Méthode de récupérer un objet couture via son ID
  Future<Couture?> getCoutureById(String coutureId) async {
    try {
      debugPrint('Fetching couture by ID: $coutureId');

      //Récupération des données couture a partir du repository
      final coutureDto = await _repository.getById(coutureId);

      if(coutureDto != null){
        //conversion du DTO en entité Couture
        return Couture(
            id: coutureId,
            description: coutureDto.description,
            price: coutureDto.price,
            title: coutureDto.title,
            imageUrl: coutureDto.imageUrl
        );
      }else {
        debugPrint('No data found for coututureId: $coutureId');
        return null;
      }
    }catch(e){
      debugPrint("Error fetching couture by ID: $e");
      rethrow;
    }
  }
}