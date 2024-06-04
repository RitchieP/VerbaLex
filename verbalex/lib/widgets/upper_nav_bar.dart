import 'package:flutter/material.dart';

import '../screen/settings_screen.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  const UpperNavBar({super.key, required this.screen});

  /// Only accepts "homepage" or "settings" as a value
  final String screen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('VerbaLex'),
      // titleTextStyle: Theme.of(context).textTheme.titleLarge,
      centerTitle: true,
      elevation: 0,
      leading: screen == "settings" || screen == "help"
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            )
          : null,
      actions: screen == "homepage"
          ? [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
              ),
            ]
          : null,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
