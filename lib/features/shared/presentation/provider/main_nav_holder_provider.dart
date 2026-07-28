import 'package:flutter/cupertino.dart';

import '../../../../app/crafty_bay_app.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';

class MainNavHolderProvider extends ChangeNotifier{
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  Future<void> changeIndex(int index) async {
    if(index == 2 || index == 3){
      if(await _checkUserAuthState() == false){
        return;
    }
    }
    _currentIndex = index;
    notifyListeners();
  }

  void backToHome(){
    changeIndex(0);
  }

  void navigateToCategory(){
    changeIndex(1);
  }

  Future<bool> _checkUserAuthState()async{
    if(await AuthController.isLoggedIn() == false){
      Navigator.pushNamed(
        CraftyBayApp.navigatorKey.currentContext!,
        SignInScreen.name,
      );
      return false;
    }else{
      return true;
    }
  }
}