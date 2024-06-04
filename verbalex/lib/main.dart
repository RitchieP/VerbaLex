import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verbalex/screen/splash_screen.dart';
import 'package:verbalex/utils/theme.dart';

void main() {
  runApp(BetterFeedback(
    theme: feedbackTheme,
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeMode.light;
    // Set the app orientation to portrait only.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'VerbaLex',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
