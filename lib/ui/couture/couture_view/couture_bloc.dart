import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';
import 'couture_interactor_list.dart';
import 'couture_event.dart';
import 'couture_state.dart';

class CoutureBloc extends Bloc<CoutureEvent, CoutureState> {
  final CoutureInteractorList interactor;

  CoutureBloc(this.interactor) : super(CoutureInitial()) {
    on<FetchCoutureEvent>(_onFetchCoutures);
    on<LoadCoutureEvent>(_onLoadCoutures);
  }

  Future<void> _onFetchCoutures(
      FetchCoutureEvent event,
      Emitter<CoutureState> emit,
      ) async {
    debugPrint("🔄 BLoC: Début de _onFetchCoutures");
    emit(CoutureLoadingState());

    try {
      final coutureStream = interactor.getCoutureStream();
      debugPrint("📡 BLoC: Stream créé");

      await emit.forEach<List<Couture>>(
        coutureStream,
        onData: (coutureData) {
          debugPrint("📊 BLoC: Données reçues - ${coutureData.length} coutures");
          return CoutureLoadedState(coutureData: coutureData);
        },
        onError: (error, stackTrace) {
          debugPrint("❌ BLoC: Erreur dans le stream - $error");
          debugPrint("📍 StackTrace: $stackTrace");
          return CoutureErrorState(message: "Erreur lors de la récupération des coutures: $error");
        },
      );
    } catch (e, stackTrace) {
      debugPrint("❌ BLoC: Erreur inattendue - $e");
      debugPrint("📍 StackTrace: $stackTrace");
      emit(CoutureErrorState(message: "Erreur inattendue : $e"));
    }
  }

  Future<void> _onLoadCoutures(
      LoadCoutureEvent event,
      Emitter<CoutureState> emit,
      ) async {
    debugPrint("🔄 BLoC: Chargement unique des coutures");
    emit(CoutureLoadingState());

    try {
      final coutures = await interactor.fetchCouture();
      debugPrint("✅ BLoC: ${coutures.length} coutures chargées");
      emit(CoutureLoadedState(coutureData: coutures));
    } catch (e) {
      debugPrint("❌ BLoC: Erreur lors du chargement - $e");
      emit(CoutureErrorState(message: "Erreur lors du chargement : $e"));
    }
  }
}