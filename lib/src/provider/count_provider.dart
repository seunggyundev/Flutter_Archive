import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  //이 안에 선언된 모든 멤버 변수들의 값들은 상태관리를 하게 되는 것

  int _count = 0;
  int get count => _count;  //_count를 외부에서 접근가능하게 하기 위함

  add() {
    _count++;
    notifyListeners();  //상태값이 업데이트되었다는 신호를 보냄, 반드시 호출해야함
  }

  remove() {
    _count--;
    notifyListeners();
  }
}