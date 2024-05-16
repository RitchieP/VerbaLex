import 'package:flutter/material.dart';

class AudioProcessingIndicator extends StatefulWidget {
  final String loadingText;

  const AudioProcessingIndicator({super.key, required this.loadingText});

  @override
  State<AudioProcessingIndicator> createState() => _AudioProcessingIndicatorState();
}

class _AudioProcessingIndicatorState extends State<AudioProcessingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).focusColor,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            widget.loadingText,
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]);
  }
}