import 'package:flutter/material.dart';
import 'package:verbalex/utils/pnc.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class PnCScreen extends StatefulWidget {
  const PnCScreen({super.key});

  @override
  State<PnCScreen> createState() => _PnCScreenState();
}

class _PnCScreenState extends State<PnCScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(screen: 'pnc'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Text(pnc)
        ),
      ),
    );
  }
}