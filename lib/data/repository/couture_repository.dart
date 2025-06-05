import 'package:firebase_storage/firebase_storage.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

abstract class CoutureRepository {
  FirebaseStorage get storage;

  Stream<Iterable<Couture>> getCoutureStream();
  Future<CoutureDto?> getById(String coutureId);
  Future<void> add(CoutureDto coutureDto);
  Future<void> deleteCouture(String coutureId);
  Future<void> uploadField(
      String coutureId,
      String fieldName,
      dynamic newValue,
      );
}