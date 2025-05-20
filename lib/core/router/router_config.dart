import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/contact/contact_module.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/couture_module.dart';
import 'package:les_petite_creations_d_alexia/ui/home_page/home_page_module.dart';

import '../di/di.dart';


@singleton
class AppRouterConfig {
  GoRouter get router => GoRouter(
    routes: [
      ...getIt<HomePageModule>().getRoutes(),
      ...getIt<CoutureModule>().getRoutes(),
      ...getIt<ContactModule>().getRoutes()

    ],

    errorBuilder: (context, state) => const ErrorPage(),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Page not found')));
  }
}