import 'package:flutter_story_app/core/state/data_state.dart';
import 'package:flutter_story_app/core/usecases/usecase.dart';
import 'package:flutter_story_app/features/story/data/models/responses/register/register_response.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';

class RegisterUseCase
    implements UseCase<DataState<RegisterResponse>, RegisterParams> {
  final StoryRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<DataState<RegisterResponse>> call({RegisterParams? params}) {
    final username = params!.username;
    final email = params.email;
    final password = params.password;

    return repository.registerUser(username, email, password);
  }
}

class RegisterParams {
  final String username;
  final String email;
  final String password;

  RegisterParams(this.username, this.email, this.password);
}
