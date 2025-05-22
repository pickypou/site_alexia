import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/firestore_service.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository_impl.dart';

void setupDataModule() {
  if (!GetIt.I.isRegistered<FirebaseFirestore>()) {
    GetIt.I.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }
  if (!GetIt.I.isRegistered<FirestoreService>()) {
    GetIt.I.registerLazySingleton<FirestoreService>(
      () => getIt<FirestoreService>(),
    );
  }

  getIt.registerLazySingleton<CoutureRepository>(() => CoutureRepositoryImpl());
}
