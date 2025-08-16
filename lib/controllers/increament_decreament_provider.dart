import 'package:flutter/material.dart';

class IncrementDecrementProvider extends ChangeNotifier {
  int _count = 1;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 1) {
      _count--;
      notifyListeners();
    }
  }
}
