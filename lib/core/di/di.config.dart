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

import '../../data/dto/couture_dto.dart' as _i1015;
import '../../data/dto/tricot_dto.dart' as _i823;
import '../../data/repository/user_repository.dart' as _i449;
import '../../data/repository/user_repository_impl.dart' as _i568;
import '../../domain/use_case/fetch_user_data_usecase.dart' as _i668;
import '../../ui/account/account_module.dart' as _i692;
import '../../ui/admin_page/admin_page_module.dart' as _i727;
import '../../ui/contact/contact_module.dart' as _i106;
import '../../ui/couture/add_couture_view/add_couture_module.dart' as _i961;
import '../../ui/couture/couture_interactor.dart' as _i621;
import '../../ui/couture/couture_view/couture_module.dart' as _i213;
import '../../ui/couture/delete_couture/delete_couture_module.dart' as _i215;
import '../../ui/home_page/home_page_module.dart' as _i147;
import '../../ui/tricots/add_tricots/add_tricot_module.dart' as _i723;
import '../../ui/tricots/delete_tricot/delete_tricot_module.dart' as _i291;
import '../../ui/tricots/tricot_interactor.dart' as _i204;
import '../../ui/tricots/tricot_view/tricot_module.dart' as _i470;
import '../../ui/ui_module.dart' as _i573;
import '../../ui/user/add_user_bloc.dart' as _i480;
import '../../ui/user/add_user_interactor.dart' as _i857;
import '../../ui/user/add_user_module.dart' as _i644;
import '../../ui/user/login/login_module.dart' as _i415;
import '../base/base_repository.dart' as _i106;
import '../router/router_config.dart' as _i718;
import 'api/auth_service.dart' as _i977;
import 'api/firebase_client.dart' as _i703;
import 'api/firestore_service.dart' as _i746;
import 'api/storage_service.dart' as _i717;
import 'firebase_module.dart' as _i616;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final firebaseModule = _$FirebaseModule();
  final appModule = _$AppModule();
  gh.factory<_i703.FirebaseClient>(() => _i703.FirebaseClient());
  await gh.factoryAsync<_i982.FirebaseApp>(
    () => firebaseModule.firebaseApp,
    preResolve: true,
  );
  gh.singleton<_i106.BaseRepository<_i1015.CoutureDto>>(
    () => appModule.coutureRepository,
  );
  gh.singleton<_i621.CoutureInteractor>(() => appModule.coutureInteractor);
  gh.singleton<_i106.BaseRepository<_i823.TricotDto>>(
    () => appModule.tricotRepository,
  );
  gh.singleton<_i204.TricotInteractor>(() => appModule.tricotInteractor);
  gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
  gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
  gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
  gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i457.FirebaseStorage>(() => firebaseModule.firebaseStorage);
  gh.singleton<_i213.CoutureModule>(
    () => _i213.CoutureModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i1015.CoutureDto>>(),
    ),
  );
  gh.singleton<_i961.AddCoutureModule>(
    () => _i961.AddCoutureModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i1015.CoutureDto>>(),
    ),
  );
  gh.singleton<_i215.DeleteCoutureModule>(
    () => _i215.DeleteCoutureModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i1015.CoutureDto>>(),
    ),
  );
  gh.singleton<_i692.AccountModule>(
    () => _i692.AccountModule(gh<_i573.AppRouter>()),
  );
  gh.singleton<_i727.AdminPageModule>(
    () => _i727.AdminPageModule(gh<_i573.AppRouter>()),
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
  gh.singleton<_i470.TricotModule>(
    () => _i470.TricotModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i823.TricotDto>>(),
    ),
  );
  gh.singleton<_i291.DeleteTricotModule>(
    () => _i291.DeleteTricotModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i823.TricotDto>>(),
    ),
  );
  gh.singleton<_i723.AddTricotModule>(
    () => _i723.AddTricotModule(
      gh<_i573.AppRouter>(),
      gh<_i106.BaseRepository<_i823.TricotDto>>(),
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
  gh.singleton<_i857.AddUserInteractor>(
    () => _i857.AddUserInteractor(userRepository: gh<_i449.UserRepository>()),
  );
  gh.singleton<_i480.AddUserBloc>(
    () => _i480.AddUserBloc(gh<_i857.AddUserInteractor>()),
  );
  return getIt;
}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$AppModule extends _i464.AppModule {}
