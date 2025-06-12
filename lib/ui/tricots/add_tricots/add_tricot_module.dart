import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'package:les_petite_creations_d_alexia/core/base/generic_action_bloc.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';
import 'package:les_petite_creations_d_alexia/ui/tricots/add_tricots/add_tricot_view.dart';
import '../../../core/base/base_repository.dart';
import '../../ui_module.dart';

@singleton
class AddTricotModule implements UIModule {
  final AppRouter _appRouter;
  final BaseRepository<TricotDto> _tricotRepository;

  AddTricotModule(this._appRouter, this._tricotRepository);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/add_tricot',
        builder: (context, state) => BlocProvider<GenericActionBloc<TricotDto>>(
          create: (_) => GenericActionBloc<TricotDto>(
            addFn: (dto) => _tricotRepository.add(dto),
            deleteFn: null, // si tu ne veux pas de suppression ici
            // tu peux ajouter updateFn si ton bloc le supporte
          ),
          child: const AddTricotView(),
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() => {};
}