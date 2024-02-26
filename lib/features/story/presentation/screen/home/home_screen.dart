import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/features/story/presentation/screen/setting/setting_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screen/story/story_screen.dart';

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedIndex = useState<int>(1);

    void onItemTapped(int index) {
      selectedIndex.value = index;
    }

    return Scaffold(
      appBar: _homeAppBar(context),
      body: Center(
        child: _screenOptions.elementAt(
          selectedIndex.value,
        ),
      ),
      floatingActionButton: _homeFabUpload(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(
        context,
        selectedIndex.value,
        onItemTapped,
      ),
    );
  }

  PreferredSizeWidget _homeAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Story App'),
    );
  }

  Widget _homeFabUpload(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.upload),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    int currentIndex,
    void Function(int index) onTap,
  ) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Story',
          icon: Icon(Icons.auto_stories),
        ),
        BottomNavigationBarItem(
          label: 'Setting',
          icon: Icon(Icons.settings),
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.indigoAccent,
      onTap: (int? index) => onTap,
    );
  }

  static const List<Widget> _screenOptions = [StoryScreen(), SettingScreen()];
}
