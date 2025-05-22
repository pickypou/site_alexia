import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:path_provider/path_provider.dart';

import 'core/di/di.dart';
import 'core/router/router_config.dart';
import 'firebase_options.dart';


Future<String> getDirectoryPath() async {
  if(kIsWeb) {
    return '/path/to/web/directory';
  }else {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouterConfig = getIt<AppRouterConfig>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Les Petites Créas d\'Alexia',
      theme: theme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      routerConfig: appRouterConfig.router,
    );
  }
}





