
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_bloc.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_interactor.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/view/remove_couture_view.dart';

import '../../../core/di/di.dart';

import '../../../data/repository/couture_repository.dart';
import '../../../domain/use_case/fetch_couture_data_usecase.dart';
import '../../ui_module.dart';




@singleton
class RemoveCoutureModule implements UIModule {
  final AppRouter _appRouter;

  RemoveCoutureModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
          path: '/remove_couture',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: _buildECoutureList(),
            );
          })
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }

  Widget _buildECoutureList() {
    return BlocProvider<RemoveCoutureBloc>(
      create: (context) {
       CoutureRepository coutureRepositoryImpl =
        getIt<CoutureRepository>();
        FetchCoutureDataUseCase fetchCoutureDataUseCase =
        getIt<FetchCoutureDataUseCase>();
        final String coutureId = '';
        var interactor = RemoveCoutureInteractor(
            getIt<FetchCoutureDataUseCase>(),
            getIt<CoutureRepository>(),
            getIt<FirebaseFirestore>(),
            getIt<FirebaseStorage>()
        );


        return RemoveCoutureBloc(interactor,  coutureId: coutureId);
      },
      child: RemoveCoutureView(),
    );
  }
}