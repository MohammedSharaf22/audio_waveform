import 'dart:async';
import 'dart:io';
import 'package:audio_wave/src/base/constants.dart';
import 'package:flutter/services.dart';

class AudioWaveInterface {
  AudioWaveInterface._();

  static AudioWaveInterface instance = AudioWaveInterface._();

  static const MethodChannel _methodChannel =
      MethodChannel(Constants.methodChannelName);

  ///platform call to start recording
  Future<bool> record([String? path]) async {
    final _isRecording = await _methodChannel.invokeMethod(
        Constants.startRecording,
        Platform.isIOS ? {Constants.path: path} : null);
    return _isRecording ?? false;
  }

  ///platform call to initialise the recorder.
  ///This method is only required for Android platform
  Future<bool> initRecorder(String? path) async {
    final initialized = await _methodChannel
        .invokeMethod(Constants.initRecorder, {Constants.path: path});
    return initialized ?? false;
  }

  ///platform call to pause recording
  Future<bool?> pause() async {
    final _isRecording =
        await _methodChannel.invokeMethod(Constants.pauseRecording);
    return _isRecording;
  }

  ///platform call to stop recording
  Future<bool> stop() async {
    final _isRecording =
        await _methodChannel.invokeMethod(Constants.stopRecording);
    return _isRecording ?? false;
  }

  ///platform call to resume recording.
  ///This method is only required for Android platform
  Future<bool> resume() async {
    final _isRecording =
        await _methodChannel.invokeMethod(Constants.resumeRecording);
    return _isRecording ?? false;
  }

  ///platform call to get decibel
  Future<double?> getDecibel() async {
    var db = await _methodChannel.invokeMethod(Constants.getDecibel);
    return db;
  }

  ///platform call to check microphone permission
  Future<bool> checkPermission() async {
    var hasPermission =
        await _methodChannel.invokeMethod(Constants.checkPermission);
    return hasPermission ?? false;
  }
}