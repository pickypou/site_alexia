import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/ui/account/account_interactor.dart';
import 'package:les_petite_creations_d_alexia/ui/account/account_state.dart';
import 'package:les_petite_creations_d_alexia/ui/account/account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;
  final String? userId;

  AccountBloc({
    required this.accountInteractor,
    required this.userId
}) : super(AccountInitial()) {
    on<LoadUserInfo>((event, emit) async {
      if ( userId != null && userId!.isNotEmpty) {
        emit(AccountLoading());
        try {
          final userData = await accountInteractor.fetchUserData(userId!);
          debugPrint("AccountBloc: Données utilisateur chargées avec succès.");
          emit(AccountLoaded(userData: userData));
        }catch(e) {
          debugPrint("AccountBloc: Erreur - ${e.toString}");
          emit(AccountError(message: e.toString()));
        }
      }else {
        debugPrint("AccountBloc: Aucun utilisateur connecté.");
        emit(AccountError(message: "aucun utilisateur connecté."));
      }
    });
  }
}