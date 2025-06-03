
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

abstract class AddCoutureState {}

class AddCoutureSignUpInitialState extends AddCoutureState {}

class AddCoutureSignUpLoadingState extends AddCoutureState {}

class AddCoutureSignUpSuccessState extends AddCoutureState {
  final String coutureId;
  AddCoutureSignUpSuccessState({required this.coutureId});
}

class AddCoutureLoadState extends AddCoutureState {
  final List<Couture> coutureData;
  AddCoutureLoadState({required this.coutureData});
}

class CoutureDetailLoadedState extends AddCoutureState {
  final Couture coutureDetail;
  CoutureDetailLoadedState({required this.coutureDetail});
}

class AddCoutureErrorState extends AddCoutureState {
  final String error;
  AddCoutureErrorState(String string, {required this.error});
}

