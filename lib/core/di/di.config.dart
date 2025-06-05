// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/couture_repository.dart' as _i1065;
import '../../data/repository/couture_repository_impl.dart' as _i551;
import '../../data/repository/user_repository.dart' as _i449;
import '../../data/repository/user_repository_impl.dart' as _i568;
import '../../domain/use_case/fetch_couture_data_usecase.dart' as _i581;
import '../../domain/use_case/fetch_user_data_usecase.dart' as _i668;
import '../../ui/account/account_module.dart' as _i692;
import '../../ui/admin_page/admin_page_module.dart' as _i727;
import '../../ui/contact/contact_module.dart' as _i106;
import '../../ui/couture/add_couture/add_couture_module.dart' as _i103;
import '../../ui/couture/add_couture/couture_interactor.dart' as _i92;
import '../../ui/couture/couture_view/couture_module.dart' as _i213;
import '../../ui/couture/remove_couture/remove_couture_interactor.dart'
    as _i328;
import '../../ui/couture/remove_couture/remove_couture_module.dart' as _i755;
import '../../ui/home_page/home_page_module.dart' as _i147;
import '../../ui/ui_module.dart' as _i573;
import '../../ui/user/add_user_bloc.dart' as _i480;
import '../../ui/user/add_user_interactor.dart' as _i857;
import '../../ui/user/add_user_module.dart' as _i644;
import '../../ui/user/login/login_module.dart' as _i415;
import '../router/router_config.dart' as _i718;
import 'api/auth_service.dart' as _i977;
import 'api/firebase_client.dart' as _i703;
import 'api/firestore_service.dart' as _i746;
import 'api/storage_service.dart' as _i717;
import 'firebase_module.dart' as _i616;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  gh.factory<_i703.FirebaseClient>(() => _i703.FirebaseClient());
  await gh.factoryAsync<_i982.FirebaseApp>(
    () => firebaseModule.firebaseApp,
    preResolve: true,
  );
  gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
  gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
  gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i457.FirebaseStorage>(() => firebaseModule.firebaseStorage);
  gh.lazySingleton<_i1065.CoutureRepository>(
    () => _i551.CoutureRepositoryImpl(
      firestore: gh<_i974.FirebaseFirestore>(),
      storage: gh<_i457.FirebaseStorage>(),
    ),
  );
  gh.singleton<_i692.AccountModule>(
    () => _i692.AccountModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i727.AdminPageModule>(
    () => _i727.AdminPageModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i213.CoutureModule>(
    () => _i213.CoutureModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i103.AddCoutureModule>(
    () => _i103.AddCoutureModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i755.RemoveCoutureModule>(
    () => _i755.RemoveCoutureModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i106.ContactModule>(
    () => _i106.ContactModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i644.AddUserModule>(
    () => _i644.AddUserModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i415.LoginModule>(
    () => _i415.LoginModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i147.HomePageModule>(
    () => _i147.HomePageModule(gh<_i573.AppRouter>()),
  );
  gh.lazySingleton<_i977.AuthService>(
    () => _i977.AuthService(gh<_i59.FirebaseAuth>()),
  );
  gh.factory<_i746.FirestoreService>(
    () => _i746.FirestoreService(gh<_i974.FirebaseFirestore>()),
  );
  gh.lazySingleton<_i449.UserRepository>(
    () => _i568.UserRepositoryImpl(
      gh<_i59.FirebaseAuth>(),
      gh<_i974.FirebaseFirestore>(),
    ),
  );
  gh.factory<_i668.FetchUserDataUseCase>(
    () => _i668.FetchUserDataUseCase(
      gh<_i568.UserRepositoryImpl>(),
      gh<String>(),
    ),
  );
  gh.factory<_i717.StorageService>(
    () => _i717.StorageService(gh<_i457.FirebaseStorage>()),
  );
  gh.factory<_i581.FetchCoutureDataUseCase>(
    () => _i581.FetchCoutureDataUseCase(gh<_i1065.CoutureRepository>()),
  );
  gh.factory<_i328.RemoveCoutureInteractor>(
    () => _i328.RemoveCoutureInteractor(
      gh<_i581.FetchCoutureDataUseCase>(),
      gh<_i1065.CoutureRepository>(),
      gh<_i974.FirebaseFirestore>(),
      gh<_i457.FirebaseStorage>(),
    ),
  );
  gh.singleton<_i857.AddUserInteractor>(
    () => _i857.AddUserInteractor(userRepository: gh<_i449.UserRepository>()),
  );
  gh.factory<_i92.CoutureInteractor>(
    () => _i92.CoutureInteractor(
      fetchCoutureDataUseCase: gh<_i581.FetchCoutureDataUseCase>(),
      coutureRepository: gh<_i1065.CoutureRepository>(),
      storageService: gh<_i717.StorageService>(),
      firestoreService: gh<_i746.FirestoreService>(),
    ),
  );
  gh.singleton<_i480.AddUserBloc>(
    () => _i480.AddUserBloc(gh<_i857.AddUserInteractor>()),
  );
  return getIt;
}

class _$FirebaseModule extends _i616.FirebaseModule {}
