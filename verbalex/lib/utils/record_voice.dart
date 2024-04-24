import 'dart:io';
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Recorder {
  final recorder = AudioRecorder();
  final player = AudioPlayer();

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      openAppSettings();
    }
  }

  Future record() async {
    final cacheDirectory = await getTemporaryDirectory();
    if (kDebugMode) print(cacheDirectory.path);
    await recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav, 
          sampleRate: 16000, 
          noiseSuppress: true
        ),
        path: '${cacheDirectory.path}/verbalex_audio.wav');
  }

  /// Stop the recording and returns a path to the audio file.
  Future<File> stop() async {
    final path = await recorder.stop();
    final audioFile = File(path!);

    if (kDebugMode) print('Audio file saved at: ${audioFile.path}');
    return audioFile;
  }

  Future closeRecorder() async {
    await recorder.dispose();
    player.dispose();
  }

  // This app does not intend to playback the audio file. This method is used
  // for debugging purposes.
  Future playAudio(File path) async {
    await player.play(DeviceFileSource(path.path));
  }
}