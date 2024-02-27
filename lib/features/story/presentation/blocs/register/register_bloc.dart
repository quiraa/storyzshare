import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/features/story/domain/usecase/register_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(const RegisterInitialState()) {
    // on<DefaultRegister>(onDefaultRegister);
    on<Register>(onRegister);
  }

  // void onDefaultRegister(DefaultRegister event, Emitter<RegisterState> emit) {}

  void onRegister(
    Register event,
    Emitter<RegisterState> emit,
  ) async {
    final dataState = await registerUseCase();

    if (dataState is DataSuccess) {
      emit(RegisterSuccessState(dataState.data!));
    }

    if (dataState is DataError) {
      emit(RegisterErrorState(dataState.errorMessage!));
    }
  }
}
