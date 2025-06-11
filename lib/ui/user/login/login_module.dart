import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/user/login/user_login_bloc.dart';
import 'package:les_petite_creations_d_alexia/ui/user/login/view/login_view.dart';

import '../../../core/di/di.dart';
import '../../../data/repository/user_repository.dart';
import '../../ui_module.dart';
import 'login_interactor.dart';

@singleton
class LoginModule implements UIModule {
  final AppRouter _appRouter;

  LoginModule(this._appRouter);
  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: _buildLoginPage(),
          );
        },
      ),
    ];
  }

  Widget _buildLoginPage() {
    return BlocProvider<UserLoginBloc>(
      create: (context) {
        UserRepository usersRepository = getIt<UserRepository>();

        var interactor = LoginInteractor(usersRepository: usersRepository);
        return UserLoginBloc(interactor);
      },
      child: LoginView(),
    );
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }
}