import 'package:flutter_story_app/core/state/ui_state.dart';
import 'package:flutter_story_app/core/usecases/usecases.dart';
import 'package:flutter_story_app/features/story/domain/entities/login_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/repository.dart';

class LoginUserUseCase
    implements UseCase<UiState<LoginResponseEntity>, LoginUserParams> {
  final Repository _repository;

  LoginUserUseCase(this._repository);

  @override
  Future<UiState<LoginResponseEntity>> call({LoginUserParams? params}) async {
    if (params == null) {
      return const ErrorState('Missing login parameters');
    }

    final email = params.email;
    final password = params.password;

    try {
      final loginResponse = await _repository.loginUser(email, password);
      if (loginResponse.data != null) {
        return SuccessState(loginResponse.data!);
      } else {
        return const ErrorState('Login response is null');
      }
    } catch (e) {
      return ErrorState(e.toString());
    }
  }
}

class LoginUserParams {
  final String email;
  final String password;

  LoginUserParams(this.email, this.password);
}
