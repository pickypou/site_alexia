import 'package:equatable/equatable.dart';

abstract class BaseListEvent<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvent<T> extends BaseListEvent<T> {}
