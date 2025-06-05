import 'package:equatable/equatable.dart';

abstract class RemoveCoutureEvent extends Equatable {
  @override
  List<Object>get props => [];
}

class LoadCoutureList extends RemoveCoutureEvent {}

 class FetchComFetchCoutureListDetail extends RemoveCoutureEvent {
  final String coutureId;
  FetchComFetchCoutureListDetail(this.coutureId);
  @override
   List<Object> get props => [coutureId];
 }

