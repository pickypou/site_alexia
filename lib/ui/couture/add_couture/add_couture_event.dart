

import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AddCoutureEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCoutureEvent extends AddCoutureEvent {}

class FetchCoutureDetailEvent extends AddCoutureEvent {
  final String coutureId;
  FetchCoutureDetailEvent(this.coutureId);
  @override
  List<Object> get props => [coutureId];
}

class CoutureSignUpEvent extends AddCoutureEvent {
  final String id;
  final String title;
  final String description;
  final String price;
  final Uint8List fileBytes;

  CoutureSignUpEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.fileBytes
});
}