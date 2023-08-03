import 'package:flutter/material.dart';

class PruebasProvider with ChangeNotifier {
  bool _seLogro = false;

  bool get seLogro => _seLogro;

  void setSeLogro(bool sino) {
    _seLogro = sino;
    notifyListeners();
  }
}
