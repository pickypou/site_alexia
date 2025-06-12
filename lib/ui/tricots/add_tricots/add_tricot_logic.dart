import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/storage_service.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';

import '../../../core/base/base_repository.dart';
import '../../../core/utils/add_item_logic.dart';

class AddTricotLogic extends AddItemLogic<TricotDto> {
  final BaseRepository<TricotDto> _repository = getIt<BaseRepository<TricotDto>>();
  final StorageService _storage = getIt<StorageService>();

  @override
  buildItem(String imageUrl, String id) {
    return TricotDto(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      price: priceController.text,
      imageUrl: imageUrl,
    );
  }

  @override
  Future<void> saveItem(TricotDto item) async {
    await _repository.add(item);
  }

  Future<void> addTricot(BuildContext context) async {
    await addItem(context, (bytes, id) => _storage.uploadFileBytes('tricot/$id.jpg', bytes));
  }
}