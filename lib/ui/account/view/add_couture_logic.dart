import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import '../../../../domain/entity/couture.dart';
import '../../../core/utils/add_item_logic.dart';
import '../../couture/add_couture/couture_interactor.dart';

class AddCoutureLogic extends AddItemLogic<Couture> {
  final CoutureInteractor _interactor = getIt<CoutureInteractor>();

  @override
  Future<void> saveItem(Couture item) {
    return _interactor.addCouture(item);
  }

  @override
  Couture buildItem(String imageUrl, String id) {
    return Couture(
      id: id,
      title: titleController.text,
      imageUrl: imageUrl,
      description: descriptionController.text,
      price: priceController.text,
    );
  }

  /// Tu peux rediriger l’appel au `addItem` avec le bon `uploadFile`
  Future<void> addCouture(BuildContext context) {
    return addItem(context, _interactor.uploadCoutureFile);
  }
}
