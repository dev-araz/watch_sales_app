import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int newIndex) {
    _pageIndex = newIndex;
    notifyListeners();
  }

  void setSelectedTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
