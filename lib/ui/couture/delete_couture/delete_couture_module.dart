import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_list_event.dart';
import '../../../core/base/base_repository.dart';
import '../../../core/base/generic_action_bloc.dart';
import '../../../core/base/generic_list_bloc.dart';
import '../../../data/dto/couture_dto.dart';
import '../../ui_module.dart';
import 'delete_couture_view.dart';
import '../couture_interactor.dart';

@singleton
class DeleteCoutureModule implements UIModule {
  final AppRouter _appRouter;
  final BaseRepository<CoutureDto> _coutureRepository;

  DeleteCoutureModule(this._appRouter, this._coutureRepository);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/delete_couture',
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<GenericListBloc<CoutureDto>>(
                create: (_) => GenericListBloc<CoutureDto>(
                  fetchList: CoutureInteractor(_coutureRepository).fetchData,
                )..add(LoadEvent()),
              ),
              BlocProvider<GenericActionBloc<CoutureDto>>(
                create: (_) => GenericActionBloc<CoutureDto>(
                  deleteFn: (id) => _coutureRepository.delete(id),
                ),
              ),
            ],
            child: const DeleteCoutureView(),
          );

        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() => {};
}