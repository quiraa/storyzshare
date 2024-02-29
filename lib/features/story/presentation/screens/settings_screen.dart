import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/routes/screens.dart';
import 'package:flutter_story_app/features/story/data/preferences/user_preference.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final switchState = useState<bool>(false);

    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context, switchState),
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

  Widget _buildBody(
    BuildContext context,
    ValueNotifier<bool> switchState,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDarkModeButton(switchState),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildLogoutButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkModeButton(ValueNotifier<bool> switchState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
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
              value: switchState.value,
              onChanged: (bool newValue) {
                switchState.value = newValue;
              },
            )
          ],
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
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
