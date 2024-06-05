import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OutputSpace extends StatefulWidget {
  const OutputSpace({super.key, this.text});

  final String? text;

  @override
  State<OutputSpace> createState() => _OutputSpaceState();
}

class _OutputSpaceState extends State<OutputSpace> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) print(widget.text);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.62,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(
            widget.text ?? "Press the record button to start recording.",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
        ),
      )
    );
  }
}
