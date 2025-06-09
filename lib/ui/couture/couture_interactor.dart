import 'package:les_petite_creations_d_alexia/core/base/base_repository.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';

class CoutureInteractor {
  final BaseRepository<CoutureDto> repository;

  CoutureInteractor(this.repository);

  Future<List<CoutureDto>> fetchData() => repository.getStream().first;
  Future<void> delete(String id) => repository.delete(id);
  Future<void> add(CoutureDto dto) => repository.add(dto);
}
