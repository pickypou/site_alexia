
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/user/view/add_user_view.dart';

import '../../../core/di/di.dart';
import '../../data/repository/user_repository.dart';
import '../ui_module.dart';
import 'add_user_bloc.dart';
import 'add_user_interactor.dart';

@singleton
class AddUserModule implements UIModule {
  final AppRouter _appRouter;
  AddUserModule(this._appRouter);
  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/addUser',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: _buildAddUserPage(),
          );
        },
      ),
    ];
  }
  Widget _buildAddUserPage() {
    return BlocProvider<AddUserBloc>(
      create: (context) {
        UserRepository usersRepository = getIt<UserRepository>();

        var interactor = AddUserInteractor(userRepository: usersRepository);
        return AddUserBloc(interactor);
      },
      child: AddUserView(),
    );
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }
}



