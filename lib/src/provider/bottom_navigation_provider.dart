import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _index = 0;
  int get currentPage => _index;

  updateCurrentPage(int index) {
    _index = index;
    notifyListeners();  //반드시 해줘야 업데이트가 됨
  }
}