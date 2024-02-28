import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/login_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitialState()) {
    on<LoginInitialEvent>(onLoginInitialEvent);
    on<LoginErrorEvent>(onLoginErrorEvent);
    on<LoginLoadingEvent>(onLoginLoadingEvent);
    on<LoginUserEvent>(onLoginUserEvent);
  }

  void onLoginUserEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    final dataState = await loginUseCase(
      params: LoginParams(
        event.email!,
        event.password!,
      ),
    );

    if (dataState is DataSuccess) {
      emit(LoginSuccessState(dataState.data!));
    }

    if (dataState is DataError) {
      emit(LoginErrorState(dataState.error!));
    }
  }

  void onLoginErrorEvent(
    LoginErrorEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginErrorState(event.error!));
  }

  void onLoginLoadingEvent(
    LoginLoadingEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginLoadingState());
  }

  void onLoginInitialEvent(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginInitialState());
  }
}
