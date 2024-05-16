import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:verbalex/widgets/output_space.dart';
import 'package:verbalex/widgets/progress_indicator.dart';
import 'package:verbalex/widgets/record_button.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var textRecognized;
  var isLoading = false;
  var loadingText = "Loading...";

  onLoading(String? loadingText) {
    setState(() {
      isLoading = true;
      this.loadingText = loadingText ?? "Loading...";
    });
  }

  onDataReturned(data) {
    setState(() {
      textRecognized = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(
        screen: "homepage",
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.transparent,
        progressIndicator: AudioProcessingIndicator(loadingText: loadingText,),
        child: Center(
            child: Column(
          children: [
            OutputSpace(text: textRecognized),
            RecordButton(
              title: "Record",
              onDataReturned: onDataReturned,
              onLoading: onLoading,
            )
          ],
        )),
      ),
    );
  }
}
