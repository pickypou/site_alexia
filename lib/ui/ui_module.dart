import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// Interface abstraite pour les modules UI
abstract class UIModule {
  void configure();

  List<RouteBase> getRoutes();

  Map<String, WidgetBuilder> getSharedWidgets();
}

mixin DefaultSharedWidgets on UIModule {
  @override
  Map<String, WidgetBuilder> getSharedWidgets() => {};
}

/// Classe singleton qui gère les routes
@singleton
class AppRouter {
  final List<RouteBase> _routes = [];

  void addRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);
  }

  List<RouteBase> get routes => _routes;
}

/// Fonction factory pour créer le GoRouter à partir de AppRouter
GoRouter createRouter(AppRouter appRouter) {
  return GoRouter(
    routes: appRouter.routes,
  );
}
