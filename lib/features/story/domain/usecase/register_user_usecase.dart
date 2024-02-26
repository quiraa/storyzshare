import 'package:flutter_story_app/core/state/ui_state.dart';
import 'package:flutter_story_app/core/usecases/usecases.dart';
import 'package:flutter_story_app/features/story/domain/entities/register_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/repository.dart';

class RegisterUserUseCase
    implements UseCase<UiState<RegisterResponseEntity>, RegisterUserParams> {
  final Repository _repository;

  RegisterUserUseCase(this._repository);

  @override
  Future<UiState<RegisterResponseEntity>> call(
      {RegisterUserParams? params}) async {
    if (params == null) {
      return const ErrorState('Missing register parameters');
    }

    final username = params.username;
    final email = params.email;
    final password = params.password;

    try {
      final registerResponse =
          await _repository.registerUser(username, email, password);
      if (registerResponse.data != null) {
        return SuccessState(registerResponse.data!);
      } else {
        return const ErrorState('Register response is null');
      }
    } catch (e) {
      return ErrorState(e.toString());
    }
  }
}

class RegisterUserParams {
  final String username;
  final String email;
  final String password;

  RegisterUserParams(this.username, this.email, this.password);
}
