

import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/contact/contact_view.dart';
import '../ui_module.dart';

@singleton
class ContactModule implements UIModule {
  final AppRouter _appRouter;
  ContactModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }
  @override
  List<RouteBase> getRoutes()  {
    return [
      GoRoute(
        path: '/contact',
        builder: (context, state) =>  ContactView(),
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    // Implémentation de la méthode manquante
    return {};
  }
}