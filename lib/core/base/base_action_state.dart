abstract class BaseActionState<T> {}
class ActionInProgressState<T> extends BaseActionState<T> {}
class ActionSuccessState<T> extends BaseActionState<T> {}
class ActionFailureState<T> extends BaseActionState<T> {
  final String message;
  ActionFailureState(this.message);
}
