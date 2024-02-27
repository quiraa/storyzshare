import 'package:dio/dio.dart';
import 'package:flutter_story_app/features/story/data/repository/story_repository_impl.dart';
// import 'package:flutter_story_app/features/story/data/shared_preferencec/user_preference.dart';
import 'package:flutter_story_app/features/story/data/sources/api/api_service.dart';
import 'package:flutter_story_app/features/story/domain/repository/story_repository.dart';
import 'package:flutter_story_app/features/story/domain/usecase/get_stories_usecase.dart';
import 'package:flutter_story_app/features/story/domain/usecase/login_usecase.dart';
import 'package:flutter_story_app/features/story/domain/usecase/register_usecase.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> initializeDependencies() async {
  // injection.registerSingleton<UserPreference>(UserPreference());

// * Register APIs
  injection.registerSingleton<Dio>(Dio());

  injection.registerSingleton<ApiService>(
    ApiService(
      injection(),
    ),
  );

// * Register Repository
  injection.registerSingleton<StoryRepository>(
    StoryRepositoryImpl(
      injection(),
    ),
  );

// * Register Use Cases
  injection.registerSingleton<GetStoriesUseCase>(
    GetStoriesUseCase(
      injection(),
    ),
  );

  injection.registerSingleton<LoginUseCase>(
    LoginUseCase(
      injection(),
    ),
  );

  injection.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      injection(),
    ),
  );

// * Register BLoCs

  injection.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      injection(),
    ),
  );

  injection.registerFactory<LoginBloc>(
    () => LoginBloc(
      injection(),
    ),
  );

  injection.registerFactory<StoryBloc>(
    () => StoryBloc(
      injection(),
    ),
  );
}
