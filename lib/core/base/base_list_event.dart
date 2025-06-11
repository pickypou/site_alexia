import 'package:equatable/equatable.dart';

abstract class BaseListEvent<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvent<T> extends BaseListEvent<T> {}
class EventGotList<T> extends BaseListEvent<T> {
  final List<T> items;

  EventGotList(this.items);
}

class EventErrorList<T> extends BaseListEvent<T> {
  final String error;

  EventErrorList(this.error);
}

