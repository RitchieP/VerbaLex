import 'package:flutter/material.dart';
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
      appBar: UpperNavBar(),
      body: const Center(
        child: Text('Welcome to VerbaLex'),
      ),
    );
  }
}
