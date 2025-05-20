// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../ui/contact/contact_module.dart' as _i106;
import '../../ui/couture/couture_module.dart' as _i277;
import '../../ui/home_page/home_page_module.dart' as _i147;
import '../../ui/ui_module.dart' as _i573;
import '../router/router_config.dart' as _i718;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
    gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
    gh.singleton<_i147.HomePageModule>(
      () => _i147.HomePageModule(gh<_i573.AppRouter>()),
    );
    gh.singleton<_i106.ContactModule>(
      () => _i106.ContactModule(gh<_i573.AppRouter>()),
    );
    gh.singleton<_i277.CoutureModule>(
      () => _i277.CoutureModule(gh<_i573.AppRouter>()),
    );
    return this;
  }
}
