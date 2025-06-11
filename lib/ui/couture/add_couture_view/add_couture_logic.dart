import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/storage_service.dart';

import '../../../core/base/base_repository.dart';
import '../../../core/utils/add_item_logic.dart';

class AddCoutureLogic extends AddItemLogic<CoutureDto> {
  final BaseRepository<CoutureDto> _repository = getIt<BaseRepository<CoutureDto>>();
  final StorageService _storage = getIt<StorageService>();

  @override
  buildItem(String imageUrl, String id) {
    return CoutureDto(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      price: priceController.text,
      imageUrl: imageUrl,
    );
  }

  @override
  Future<void> saveItem(CoutureDto item) async {
    await _repository.add(item);
  }

  Future<void> addCouture(BuildContext context) async {
    await addItem(context, (bytes, id) => _storage.uploadFileBytes('couture/$id.jpg', bytes));
  }
}
