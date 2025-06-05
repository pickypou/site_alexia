
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

abstract class RemoveCoutureState {}

class RemoveCoutureInitialState extends RemoveCoutureState {}

class RemoveCoutureLoadingState extends RemoveCoutureState {}

class RemoveCoutureLoadState extends RemoveCoutureState {
  final List<Couture> coutureData;
  RemoveCoutureLoadState({required this.coutureData});
}

class RemoveCoutureSuccessState extends RemoveCoutureState {
  final String coutureId;
  RemoveCoutureSuccessState({required this.coutureId});
}

class RemoveCoutureErrorState extends RemoveCoutureState {
  final String error;
  RemoveCoutureErrorState({required this.error});
}