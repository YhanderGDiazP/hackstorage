import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ConnectivityResult? _connectivityResult;

  void connectivityResultSet(ConnectivityResult connectivityResult) {
    _connectivityResult = connectivityResult;
    notifyListeners();
  }

  ConnectivityResult? get connectivityResultGet => _connectivityResult;
}
