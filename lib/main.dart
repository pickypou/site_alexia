import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';

import 'core/di/di.dart';
import 'core/router/router_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouterConfig = getIt<AppRouterConfig>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Les Petites Créas d\'Alexia',
      theme: theme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: appRouterConfig.router,
    );
  }
}
