import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/account/view/account_page.dart';

import '../../core/di/di.dart';

import '../../data/repository/user_repository.dart';
import '../ui_module.dart';
import '../user/login/user_login_bloc.dart';
import '../user/login/view/login_view.dart';
import 'account_interactor.dart';
import 'account_bloc.dart';

@singleton
class AccountModule implements UIModule {
  final AppRouter _appRouter;

  AccountModule(this._appRouter); // S'assurer que l'argument est ici

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/account',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: _buildAccountPage(),
          );
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }

  Widget _buildAccountPage() {
    final String? userId = getIt<FirebaseAuth>().currentUser?.uid;

    if (userId != null) {
      return BlocProvider<AccountBloc>(
        create: (context) {
          UserRepository userRepository = getIt<UserRepository>();
          var interactor = AccountInteractor(userRepository, userId);
          return AccountBloc(accountInteractor: interactor, userId: userId);
        },
        child: const AccountPage(),
      );
    } else {
      return BlocProvider<UserLoginBloc>(
        create: (_) => getIt<UserLoginBloc>(),
        child: LoginView(),
      );
    }
  }
}