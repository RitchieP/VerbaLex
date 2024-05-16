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
      child: TextField(
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Color.fromARGB(255, 58, 80, 107)),

        /**
         * The text field was not meant to be edited by the user, 
         * it will only show text
         */
        readOnly: true,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 231, 234, 239),
          filled: true,
          hintText: widget.text ?? "Press the record button to start recording",
          // Remove all the borders around the text field.
          border: InputBorder.none,
          /**
           * The contentPadding is more for the bottom padding because we want
           * to set the size of the text field to span almost the entire screen.
           */
          contentPadding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.01,
              MediaQuery.of(context).size.height * 0.01,
              MediaQuery.of(context).size.width * 0.01,
              MediaQuery.of(context).size.height * 0.6),
        ),
      ),
    );
  }
}
