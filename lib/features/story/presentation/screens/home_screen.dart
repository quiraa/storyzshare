import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/features/story/presentation/screens/maps_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/settings_screen.dart';
import 'package:flutter_story_app/features/story/presentation/screens/story_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPageIndex = useState<int>(0);

    return Scaffold(
      body: screens.elementAt(selectedPageIndex.value),
      bottomNavigationBar: _buildNavBar(context, selectedPageIndex),
    );
  }

  Widget _buildNavBar(
    BuildContext context,
    ValueNotifier<int> selectedPageIndex,
  ) {
    return NavigationBar(
      selectedIndex: selectedPageIndex.value,
      onDestinationSelected: (int value) => selectedPageIndex.value = value,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          selectedIcon: Icon(Icons.auto_stories_rounded),
          icon: Icon(Icons.auto_stories_outlined),
          label: 'Story',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.location_on_rounded),
          icon: Icon(Icons.location_on_outlined),
          label: 'Maps',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.settings_rounded),
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }

  static const List<Widget> screens = [
    StoryScreen(),
    MapsScreen(),
    SettingsScreen(),
  ];
}
