// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/couture_repository_impl.dart' as _i551;
import '../../domain/use_case/fetch_couture_data_usecase.dart' as _i581;
import '../../ui/contact/contact_module.dart' as _i106;
import '../../ui/couture/couture_module.dart' as _i277;
import '../../ui/home_page/home_page_module.dart' as _i147;
import '../../ui/ui_module.dart' as _i573;
import '../router/router_config.dart' as _i718;
import 'api/firebase_client.dart' as _i703;
import 'api/firestore_service.dart' as _i746;
import 'di_module.dart' as _i211;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i703.FirebaseClient>(() => _i703.FirebaseClient());
    gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
    gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
    gh.singletonAsync<_i982.FirebaseApp>(() => firebaseModule.firebase);
    gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.singleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
    gh.singleton<_i277.CoutureModule>(
      () => _i277.CoutureModule(gh<_i573.AppRouter>()),
    );
    gh.singleton<_i106.ContactModule>(
      () => _i106.ContactModule(gh<_i573.AppRouter>()),
    );
    gh.singleton<_i147.HomePageModule>(
      () => _i147.HomePageModule(gh<_i573.AppRouter>()),
    );
    gh.factory<_i746.FirestoreService>(
      () => _i746.FirestoreService(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i551.CoutureRepositoryImpl>(
      () => _i551.CoutureRepositoryImpl(
        firestore: gh<_i974.FirebaseFirestore>(),
        storage: gh<_i457.FirebaseStorage>(),
      ),
    );
    gh.factory<_i581.FetchCoutureDataUseCase>(
      () => _i581.FetchCoutureDataUseCase(gh<_i551.CoutureRepositoryImpl>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i211.FirebaseModule {}
