import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/features/story/data/preferences/user_preference.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/login/login_event.dart';
import 'package:flutter_story_app/features/story/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Settings'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => AppRouter.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDarkModeButton(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildLogoutButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeButton(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Enable Dark Mode',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (bool newValue) {
                    themeProvider.toggleTheme(newValue);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.redAccent,
        child: InkWell(
          onTap: () {
            logout(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    bool? confirmed = await showConfirmationDialog(context);
    if (confirmed == true) {
      await UserPreference.clearToken();
      BlocProvider.of<LoginBloc>(context).add(const LoginInitialEvent());
      AppRouter.pushAndRemoveUntil(context, Screens.login);
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.logout_rounded),
          title: const Text(
            'Logout',
          ),
          content: const Text('Are you sure want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
