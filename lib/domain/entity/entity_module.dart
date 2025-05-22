

import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

void setupEntityModule() {
  getIt.registerFactory<Couture>(() =>
  Couture(
      id: 'id',
      text: '',
      title: '',
      imageUrl: ''
  ));
}