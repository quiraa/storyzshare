import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/core/usecases/usecase.dart';
import 'package:flutter_story_app/features/story/data/models/responses/login/login_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';

class LoginUseCase implements UseCase<DataState<LoginResponse>, LoginParams> {
  final StoryRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<DataState<LoginResponse>> call({LoginParams? params}) {
    final email = params!.email;
    final password = params.password;
    return repository.loginUser(email, password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(this.email, this.password);
}
