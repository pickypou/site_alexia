import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/couture_interactor.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/ui/tricots/tricot_interactor.dart';
import 'di.dart';

@module
abstract class AppModule {
  @singleton
  BaseRepository<CoutureDto> get coutureRepository => BaseRepository<CoutureDto>(
    collectionName: 'couture',
    fromMap: (Map<String, dynamic> json, String id) => CoutureDto.fromJson(json), // Correction ici
    addImageToEntity: (CoutureDto dto, String imageUrl) => dto.copyWith(imageUrl: imageUrl),
  );

  @singleton
  CoutureInteractor get coutureInteractor => CoutureInteractor(getIt<BaseRepository<CoutureDto>>());


@singleton
BaseRepository<TricotDto> get tricotRepository => BaseRepository<TricotDto>(
  collectionName: 'tricot',
  fromMap: (Map<String, dynamic> json, String id) => TricotDto.fromJson(json), // Correction ici
  addImageToEntity: (TricotDto dto, String imageUrl) => dto.copyWith(imageUrl: imageUrl),
);

@singleton
TricotInteractor get tricotInteractor => TricotInteractor(getIt<BaseRepository<TricotDto>>());


}


