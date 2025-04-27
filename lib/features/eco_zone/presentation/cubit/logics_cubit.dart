// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled/features/eco_zone/data/repo/repo.dart';

part 'logics_state.dart';

class LogicsCubit extends Cubit<LogicsState> {
  Repo repo;
  LogicsCubit({required this.repo}) : super(LogicsInitial());


  void register(String userName, String email, String password) async {
    try {
      emit(SignUpLoading());
      await repo.register(userName, email, password);
      emit(SignUpSuccess('registration successful'));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }

  void login(String email, String password) async {
    try {
      emit(LoginLoading());
       
      await repo.login(email, password);
      emit(LoginSuccess('login successful'));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
