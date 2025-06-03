import 'package:get_it/get_it.dart';
import 'package:les_petite_creations_d_alexia/data/repository/couture_repository_impl.dart';
import 'package:les_petite_creations_d_alexia/data/repository/user_repository_impl.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_user_data_usecase.dart';

final GetIt getIt = GetIt.instance;

void setupUseCaseModule() {
  getIt.registerLazySingleton<FetchCoutureDataUseCase>(
    () => FetchCoutureDataUseCase(getIt<CoutureRepositoryImpl>()),
  );

  getIt.registerFactoryParam<FetchUserDataUseCase, String, void>(
    (userId, _) => FetchUserDataUseCase(getIt<UserRepositoryImpl>(), userId),
  );
}
