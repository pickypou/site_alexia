
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:les_petite_creations_d_alexia/core/di/api/storage_service.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository_impl.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/couture_interactor.dart';

import '../../core/di/api/firestore_service.dart';
import '../../core/di/di.dart';
import 'couture_repository.dart';
import 'couture_repository_impl.dart';

void setupDataModule() {


  getIt.registerLazySingleton<CoutureRepository>(
          () => CoutureRepositoryImpl());



  getIt.registerLazySingleton<UserRepository>(() =>
      UserRepositoryImpl(getIt<FirebaseAuth>(),getIt<FirebaseFirestore>()) );

  getIt.registerLazySingleton<CoutureInteractor>(
          () => CoutureInteractor(

              coutureRepository: getIt<CoutureRepositoryImpl>(),

            firestoreService: getIt<FirestoreService>(),
            fetchCoutureDataUseCase: getIt<FetchCoutureDataUseCase>(), storageService: getIt<StorageService>(),
  ));


}