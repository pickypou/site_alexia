

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() async => init(getIt);