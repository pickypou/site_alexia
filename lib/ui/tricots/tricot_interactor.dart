

import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';

class TricotInteractor {
  final BaseRepository<TricotDto> repository;

  TricotInteractor(this.repository);

  Future<List<TricotDto>> fetchData() => repository
      .getStream(
    collectionName: 'tricot',
    fromMap: (Map<String, dynamic> data, String id) {
      return TricotDto.fromJson(data).copyWith(id: id);
    },
  )
      .first;

  Future<void> delete(String id) => repository.delete(id);
  Future<void> add(TricotDto dto) => repository.add(dto);
}
