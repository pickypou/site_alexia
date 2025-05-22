import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository_impl.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'package:flutter/material.dart';

@injectable
class FetchCoutureDataUseCase {
  final CoutureRepositoryImpl coutureRepositoryImpl;

  FetchCoutureDataUseCase(this.coutureRepositoryImpl);

  ///Méthode pour récupérer tous les objet couture
  Future<List<Couture>> getCouture() async {
    try {
      debugPrint('Fetching couture data from Firestore...');

      //Ecoute du stream pour récupérer les objet
      final coutureStream = coutureRepositoryImpl.getCoutureStream();

      //Liste pour stocker les objets récupérer
      List<Couture> coutureList = [];
      await for (var coutureIterable in coutureStream) {
        coutureList.addAll(coutureIterable);
      }
      return coutureList;
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
      final coutureDto = await coutureRepositoryImpl.getById(coutureId);

      if(coutureDto != null){
        //conversion du DTO en entité Couture
        return Couture(
            id: coutureId,
            text: coutureDto.text,
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
