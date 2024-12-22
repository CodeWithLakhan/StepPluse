import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HealthDataProvider extends ChangeNotifier {
  int _heartRate = 0;
  int _steps = 0;
  bool _isWatchConnected = false;

  int get heartRate => _heartRate;
  int get steps => _steps;
  bool get isWatchConnected => _isWatchConnected;

  StreamSubscription<int>? _heartRateSubscription;
  StreamSubscription<int>? _stepCountSubscription;

  bool _isDataSyncEnabled = true;
  bool _isNotificationsEnabled = true;

  bool get isDataSyncEnabled => _isDataSyncEnabled;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  void toggleDataSync(bool value) {
    _isDataSyncEnabled = value;
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _isNotificationsEnabled = value;
    notifyListeners();
  }

  // Mock Bluetooth SDK
  Stream<int> getHeartRateStream() async* {
    while (_isWatchConnected) {
      await Future.delayed(const Duration(seconds: 2));
      yield 60 + (10 * (1 - Random().nextDouble())).toInt();
    }
  }

  Stream<int> getStepCountStream() async* {
    int steps = 0;
    while (_isWatchConnected) {
      await Future.delayed(const Duration(seconds: 5));
      steps += Random().nextInt(10);
      yield steps;
    }
  }

  // Connect to the watch
  void connectWatch() {
    _isWatchConnected = true;
    _startFetchingData();
    notifyListeners();
  }

  // Disconnect from the watch
  void disconnectWatch() {
    _isWatchConnected = false;
    _stopFetchingData();
    notifyListeners();
  }

  // Initialize streams
  void _startFetchingData() {
    _heartRateSubscription = getHeartRateStream().listen((data) {
      _heartRate = data;
      notifyListeners();
    });

    _stepCountSubscription = getStepCountStream().listen((data) {
      _steps = data;
      notifyListeners();
    });
  }

  // Dispose streams
  void _stopFetchingData() {
    _heartRateSubscription?.cancel();
    _stepCountSubscription?.cancel();
    _heartRateSubscription = null;
    _stepCountSubscription = null;
  }

  @override
  void dispose() {
    _stopFetchingData();
    super.dispose();
  }
}
