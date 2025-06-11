import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:les_petite_creations_d_alexia/ui/user/add_user_event.dart';
import 'package:les_petite_creations_d_alexia/ui/user/add_user_interactor.dart';
import 'package:les_petite_creations_d_alexia/ui/user/add_user_state.dart';

import '../../domain/entity/users.dart';
@singleton
class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AddUserInteractor interactor;


  AddUserBloc(this.interactor) : super(SignUpInitialState()) {
    on<AddUserSignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        final user = Users(
          id: event.id,
          email: event.email,
          password: event.password,
          userName: event.userName,
        );
        event.navigateToAccount();
        await interactor.registerUser(user);
        emit(SignUpSuccessState(userId: ''));
      } catch (e) {
        emit(SignUpErrorState(e.toString()));
      }
    });
  }
}
