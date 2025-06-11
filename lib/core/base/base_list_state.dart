abstract class BaseListState<T> {}
class LoadingState<T> extends BaseListState<T> {}
class LoadState<T> extends BaseListState<T> {
  final List<T> items;
  LoadState(this.items);
}
class ErrorState<T> extends BaseListState<T> {
  final String message;
  ErrorState(this.message);
}
