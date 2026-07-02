import 'package:flutter/cupertino.dart';

class MainNavHolderProvider extends ChangeNotifier{
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

  void backToHome(){
    changeIndex(0);
  }

  void navigateToCategory(){
    changeIndex(1);
  }
}