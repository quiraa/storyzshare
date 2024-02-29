import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/config/themes/themes.dart';
import 'package:flutter_story_app/di/injection.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => injection()),
        BlocProvider<RegisterBloc>(create: (context) => injection()),
        BlocProvider<StoryBloc>(
          create: (context) => injection()..add(const GetStoriesEvent()),
        ),
        BlocProvider<UploadBloc>(create: (context) => injection()),
        BlocProvider<DetailBloc>(create: (context) => injection()),
      ],
      child: MaterialApp(
        title: 'Story App',
        onGenerateRoute: generateRoute,
        theme: StoryTheme().storyTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: Screens.splash,
      ),
    );
  }
}
