import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/register_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitialState()) {
    on<RegisterInitialEvent>(onRegisterInitialEvent);
    on<RegisterErrorEvent>(onRegisterErrorEvent);
    on<RegisterLoadingEvent>(onRegisterLoadingEvent);
    on<RegisterUserEvent>(onRegisterUserEvent);
  }

  void onRegisterUserEvent(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoadingState());

    final dataState = await registerUseCase(
      params: RegisterParams(
        event.username!,
        event.email!,
        event.password!,
      ),
    );

    if (dataState is DataSuccess) {
      emit(RegisterSuccessState(dataState.data!));
    } else {
      emit(RegisterErrorState(dataState.error!));
    }
  }

  void onRegisterLoadingEvent(
    RegisterLoadingEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(RegisterLoadingState());
  }

  void onRegisterErrorEvent(
    RegisterErrorEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(RegisterErrorState(event.error!));
  }

  void onRegisterInitialEvent(
    RegisterInitialEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(RegisterInitialState());
  }
}
