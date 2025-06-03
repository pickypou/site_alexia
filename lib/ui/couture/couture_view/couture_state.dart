import 'package:equatable/equatable.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

abstract class CoutureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoutureInitial extends CoutureState {}

class CoutureLoadingState extends CoutureState {}

class CoutureLoadedState extends CoutureState {
  final List<Couture> coutureData;

  CoutureLoadedState({required this.coutureData});

  @override
  List<Object?> get props => [coutureData];
}

class CoutureErrorState extends CoutureState {
  final String message;

  CoutureErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
