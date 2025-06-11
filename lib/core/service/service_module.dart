import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/firestore_service.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/core/service/entity_download_service.dart';


import '../../core/service/upload_entity_service.dart';

void setupServiceModule() {
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

  getIt.registerLazySingleton(() => EntityDownloadService(
getIt<FirebaseFirestore>()
  ));


  getIt.registerSingleton<UploadEntityService>(
    UploadEntityService(
      firestore: getIt<FirebaseFirestore>(),
      storage: getIt<FirebaseStorage>(),
    ),
  );
}
