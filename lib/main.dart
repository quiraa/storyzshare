import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/di/injection.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/detail/detail_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/register/register_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_event.dart';
import 'package:flutter_story_app/features/story/presentation/screens/story_screen.dart';

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
        BlocProvider<DetailBloc>(
          create: (context) => injection(),
        )
      ],
      child: MaterialApp(
        title: 'Story App',
        onGenerateRoute: generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigoAccent,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: StoryScreen(),
      ),
    );
  }
}
