import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/login_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(const LoginInitialState()) {
    on<DefaultLogin>(onDefaultLogin);
    on<Login>(onLogin);
  }

  void onDefaultLogin(DefaultLogin event, Emitter<LoginState> emit) {}

  void onLogin(
    Login event,
    Emitter<LoginState> emit,
  ) async {
    final dataState = await loginUseCase();

    if (dataState is DataSuccess) {
      emit(LoginSuccessState(dataState.data!));
    }

    if (dataState is DataError) {
      emit(LoginErrorState(dataState.errorMessage!));
    }
  }
}
