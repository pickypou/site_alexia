import 'package:equatable/equatable.dart';

abstract class CoutureEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCoutureEvent extends CoutureEvent {}


class FetchCoutureEvent extends CoutureEvent {}

class FetchCoutureDetailEvent extends CoutureEvent {
  final String coutureId;

  FetchCoutureDetailEvent(this.coutureId);

  @override
  List<Object> get props => [coutureId];
}
