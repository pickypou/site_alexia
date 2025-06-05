import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/account/account_module.dart';
import 'package:les_petite_creations_d_alexia/ui/admin_page/admin_page_module.dart';
import 'package:les_petite_creations_d_alexia/ui/contact/contact_module.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/add_couture_module.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/couture_view/couture_module.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_module.dart';
import 'package:les_petite_creations_d_alexia/ui/home_page/home_page_module.dart';
import 'package:les_petite_creations_d_alexia/ui/user/add_user_module.dart';
import 'package:les_petite_creations_d_alexia/ui/user/login/login_module.dart';

import '../di/di.dart';


@singleton
class AppRouterConfig {
  GoRouter get router => GoRouter(
    routes: [
      ...getIt<HomePageModule>().getRoutes(),
      ...getIt<CoutureModule>().getRoutes(),
      ...getIt<ContactModule>().getRoutes(),
      ...getIt<AdminPageModule>().getRoutes(),
      ...getIt<AddUserModule>().getRoutes(),
      ...getIt<LoginModule>().getRoutes(),
      ...getIt<AccountModule>().getRoutes(),
      ...getIt<AddCoutureModule>().getRoutes(),
      ...getIt<RemoveCoutureModule>().getRoutes()


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