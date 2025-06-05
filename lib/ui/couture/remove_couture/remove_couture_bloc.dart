

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_event.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_interactor.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_state.dart';

class RemoveCoutureBloc extends Bloc<RemoveCoutureEvent, RemoveCoutureState> {
  final RemoveCoutureInteractor interactor;
  final String coutureId;

  RemoveCoutureBloc(this.interactor, {required this.coutureId})
  : super(RemoveCoutureLoadingState());

  Stream<RemoveCoutureState> mapCoutToState(RemoveCoutureEvent event) async* {
    if( event is RemoveCoutureLoadState) {
      yield RemoveCoutureLoadingState();
      try {
        final couture = await interactor.fetchCoutureData();
        yield RemoveCoutureLoadState(coutureData: couture);
      }catch (e) {
        yield RemoveCoutureErrorState(
            error: "Une erreur s'est produite : $e");
      }
    }
  }
}