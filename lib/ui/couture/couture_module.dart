

import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/couture.dart';
import '../ui_module.dart';

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
        builder: (context, state) =>  Couture(),
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    // Implémentation de la méthode manquante
    return {};
  }
}