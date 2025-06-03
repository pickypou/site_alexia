

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import '../ui_module.dart';
import 'couture_view/couture_bloc.dart';
import 'couture_view/couture_interactor_list.dart';
import 'couture_view/couture_event.dart';
import 'couture_view/view/couture_view.dart';

@singleton
class CoutureModule implements UIModule {
  final AppRouter _appRouter;
  CoutureModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }
  @override
  List<RouteBase> getRoutes()  {
    return [
      GoRoute(
        path: '/couture',
        builder: (context, state) => BlocProvider(
          create: (_) => CoutureBloc(CoutureInteractorList())..add(LoadCoutureEvent()),
          child: const CoutureView(),
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    // Implémentation de la méthode manquante
    return {};
  }
}