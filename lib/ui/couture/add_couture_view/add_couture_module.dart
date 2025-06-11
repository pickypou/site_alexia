import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'package:les_petite_creations_d_alexia/core/base/generic_action_bloc.dart';
import '../../../core/base/base_repository.dart';
import '../../../data/dto/couture_dto.dart';
import '../../ui_module.dart';
import 'add_couture_view.dart';

@singleton
class AddCoutureModule implements UIModule {
  final AppRouter _appRouter;
  final BaseRepository<CoutureDto> _coutureRepository;

  AddCoutureModule(this._appRouter, this._coutureRepository);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/add_couture',
        builder: (context, state) => BlocProvider<GenericActionBloc<CoutureDto>>(
          create: (_) => GenericActionBloc<CoutureDto>(
            addFn: (dto) => _coutureRepository.add(dto),
            deleteFn: null, // si tu ne veux pas de suppression ici
            // tu peux ajouter updateFn si ton bloc le supporte
          ),
          child: const AddCoutureView(),
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() => {};
}
