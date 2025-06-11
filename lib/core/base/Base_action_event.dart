

import 'package:equatable/equatable.dart';

abstract class BaseActionEvent<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddItemEvent<T> extends BaseActionEvent<T> {
  final T item;
  AddItemEvent(this.item);
}

class DeleteItemEvent<T> extends BaseActionEvent<T> {
  final String id;
  DeleteItemEvent(this.id);
}
