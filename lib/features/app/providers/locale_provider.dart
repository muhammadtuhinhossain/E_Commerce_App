import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier{

  Locale _currentLocale = Locale('en');
  final List<Locale> _locales = [Locale('en'), Locale('bn')];
  List<Locale> get supportedLocales=> _locales;
  Locale get currentLocale =>_currentLocale;

  void changeLocale(Locale local){
    _currentLocale = local;
    _saveLocale(local);
    notifyListeners();
  }

  Future<void> _saveLocale(Locale locale)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', locale.languageCode);
  }

  Future<void> setDefaultLocale()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? locale= sharedPreferences.getString('local');
    if(locale != null){
      _currentLocale = Locale(locale);
    }
  }
}