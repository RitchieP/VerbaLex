import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbalex/screen/splash_screen.dart';
import 'package:verbalex/utils/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: BetterFeedback(theme: feedbackTheme, child: const MyApp()),
  ));
}

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode;

  ThemeNotifier() : _isDarkMode = false {
    loadFromPrefs();
  }

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    saveToPrefs();
    notifyListeners();
  }

  loadFromPrefs() async {
    await SharedPreferences.getInstance().then((prefs) {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      notifyListeners();
    });
  }

  saveToPrefs() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // Set the app orientation to portrait only.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'VerbaLex',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.currentTheme,
      home: const SplashScreen(),
    );
  }
}
