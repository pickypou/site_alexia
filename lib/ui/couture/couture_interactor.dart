import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';

class CoutureInteractor {
  final BaseRepository<CoutureDto> repository;

  CoutureInteractor(this.repository);

  Future<List<CoutureDto>> fetchData() => repository
      .getStream(
    collectionName: 'couture', // ⚠️ mets ici le nom réel de ta collection
    fromMap: (Map<String, dynamic> data, String id) {
      return CoutureDto.fromJson(data).copyWith(id: id);
    },
  )
      .first;

  Future<void> delete(String id) => repository.delete(id);
  Future<void> add(CoutureDto dto) => repository.add(dto);
}
