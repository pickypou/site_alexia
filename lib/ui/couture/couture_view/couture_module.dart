import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import '../../../core/base/base_list_event.dart';
import '../../../core/base/base_repository.dart';
import '../../../core/base/generic_list_bloc.dart';
import '../../../data/dto/couture_dto.dart';
import '../../ui_module.dart';
import '../couture_interactor.dart';
import 'couture_view.dart';

@singleton
class CoutureModule implements UIModule {
  final AppRouter _appRouter;
  final BaseRepository<CoutureDto> _coutureRepository;

  CoutureModule(this._appRouter, this._coutureRepository);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/couture',
        builder: (context, state) => BlocProvider(
          create: (_) => GenericListBloc<CoutureDto>(
            fetchList: CoutureInteractor(_coutureRepository).fetchData,
          )..add(LoadEvent()),
          child: const CoutureView(),
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }
}