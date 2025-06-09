import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_list_event.dart';
import 'base_list_state.dart';

class GenericListBloc<T> extends Bloc<BaseListEvent<T>, BaseListState<T>> {
  final Future<List<T>> Function() fetchList;

  GenericListBloc({ required this.fetchList }) : super(LoadingState<T>()) {
    on<LoadEvent<T>>((_, emit) async {
      emit(LoadingState<T>());
      try {
        final items = await fetchList();
        emit(LoadState<T>(items));
      } catch (e) {
        emit(ErrorState<T>(e.toString()));
      }
    });
  }
}
