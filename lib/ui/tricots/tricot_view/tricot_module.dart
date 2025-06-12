import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';
import 'package:les_petite_creations_d_alexia/ui/tricots/tricot_interactor.dart';
import 'package:les_petite_creations_d_alexia/ui/tricots/tricot_view/tricot_view.dart';
import '../../../core/base/base_list_event.dart';
import '../../../core/base/base_repository.dart';
import '../../../core/base/generic_list_bloc.dart';
import '../../ui_module.dart';

@singleton
class TricotModule implements UIModule {
  final AppRouter _appRouter;
  final BaseRepository<TricotDto> _tricotRepository;

  TricotModule(this._appRouter, this._tricotRepository);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/tricot',
        builder: (context, state) => BlocProvider(
          create: (_) => GenericListBloc<TricotDto>(
            fetchList: TricotInteractor(_tricotRepository).fetchData,
          )..add(LoadEvent()),
          child: const TricotView(),
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }
}