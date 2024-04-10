import 'package:flutter/material.dart';
import 'package:verbalex/widgets/output_space.dart';
import 'package:verbalex/widgets/record_button.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(
        screen: "homepage",
      ),
      body: Center(
          child: Column(
        children: const [
          OutputSpace(),
          RecordButton(
            title: "Record",
            onPressedTitle: "Recording",
          )
        ],
      )),
    );
  }
}
