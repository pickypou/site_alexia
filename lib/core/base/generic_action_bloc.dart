import 'package:flutter_bloc/flutter_bloc.dart';

import 'Base_action_event.dart';
import 'base_action_state.dart';

class GenericActionBloc<T> extends Bloc<BaseActionEvent<T>, BaseActionState<T>> {
  final Future<void> Function(T item)? addFn;
  final Future<void> Function(String id)? deleteFn;

  GenericActionBloc({ this.addFn, this.deleteFn }) : super(ActionSuccessState<T>()) {
    on<AddItemEvent<T>>((e, emit) async {
      if (addFn == null) return;
      emit(ActionInProgressState<T>());
      try {
        await addFn!(e.item);
        emit(ActionSuccessState<T>());
      } catch (e) {
        emit(ActionFailureState<T>(e.toString()));
      }
    });

    on<DeleteItemEvent<T>>((e, emit) async {
      if (deleteFn == null) return;
      emit(ActionInProgressState<T>());
      try {
        await deleteFn!(e.id);
        emit(ActionSuccessState<T>());
      } catch (e) {
        emit(ActionFailureState<T>(e.toString()));
      }
    });
  }
}
