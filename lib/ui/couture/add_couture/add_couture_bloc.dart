import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/add_couture_event.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/add_couture_state.dart';
import '../../../core/service/upload_entity_service.dart';

class AddCoutureBloc extends Bloc<AddCoutureEvent, AddCoutureState> {
  final UploadEntityService uploadService = getIt<UploadEntityService>();

  AddCoutureBloc() : super(AddCoutureSignUpInitialState()) {
    on<CoutureSignUpEvent>(_handleCoutureUpload);
  }

  Future<void> _handleCoutureUpload(
      CoutureSignUpEvent event, Emitter<AddCoutureState> emit) async {
    emit(AddCoutureSignUpLoadingState());

    try {
      // Génère un ID unique ici si nécessaire
      final coutureId = event.id; // ou : const Uuid().v4();

      await uploadService.uploadEntity(
        id: coutureId,
        collectionName: 'couture',
        title: event.title,
        description: event.description,
        price: event.price,
        fileBytes: event.fileBytes,
      );

      emit(AddCoutureSignUpSuccessState(coutureId: coutureId));
    } catch (e) {
      emit(AddCoutureErrorState(e.toString(), error: 'Erreur lors de l’upload.'));
    }
  }
}
