import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/ui/user/login/user_login_event.dart';
import 'package:les_petite_creations_d_alexia/ui/user/login/user_login_state.dart';

import 'login_interactor.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final LoginInteractor userInteractor;

  UserLoginBloc(this.userInteractor) : super(UserLoginInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      try {
        final userId = userInteractor.getCurrentUserId();
        final userData = await userInteractor.fetchUserData(userId);
        emit(UserDataLoadedState(userData));
      } catch (e) {
        emit(AuthenticationErrorState());
      }
    });

    on<LoginWithEmailPassword>((event, emit) async {
      emit(UserLoginLoading());
      try {
        await userInteractor.login(event.email, event.password);
        final userId = userInteractor.getCurrentUserId();
        final userData = await userInteractor.fetchUserData(userId);
        emit(UserDataLoadedState(userData));
        event.navigateToAccount();
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        await userInteractor.logOut();
        emit(UserLoginInitial());
      } catch (error) {
        emit(AuthenticationErrorState());
      }
    });
  }
}
