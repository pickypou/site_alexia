

import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/view/add_couture_view.dart';

import '../../ui_module.dart';

@singleton
class AddCoutureModule implements UIModule {
  final AppRouter _appRouter;
  AddCoutureModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }
  @override
  List<RouteBase> getRoutes()  {
    return [
      GoRoute(
        path: '/addcouture',
        builder: (context, state) =>  AddCoutureView(),
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    // Implémentation de la méthode manquante
    return {};
  }
}