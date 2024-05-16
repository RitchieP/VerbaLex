import 'dart:async';

import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbalex/screen/home_screen.dart';
import 'package:verbalex/utils/accents.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Welcome to VerbaLex",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          // Space between text and button
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const IntroChooseAccent()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
                overlayColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).focusColor),
              ),
              child: const Text(
                "Let's Go",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ))
        ],
      ),
    ));
  }
}

class IntroChooseAccent extends StatefulWidget {
  const IntroChooseAccent({super.key});

  @override
  State<IntroChooseAccent> createState() => _IntroChooseAccentState();
}

class _IntroChooseAccentState extends State<IntroChooseAccent> {
  Future setAccent(String accent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("accent", accent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose your accent",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: ACCENTS.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Flag.fromString(
              ACCENT_CODES[ACCENTS[index]].toString(),
              height: 35,
              borderRadius: 40.0,
            ),
            onTap: () {
              setAccent(ACCENTS[index]);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const IntroEndScreen(),
              ));
            },
          );
        },
      ),
    );
  }
}

class IntroEndScreen extends StatelessWidget {
  const IntroEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
    return const Scaffold(
      body: Center(
        child: Text(
          "You're all set!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
