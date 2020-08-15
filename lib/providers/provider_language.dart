import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderLanguage extends ChangeNotifier {
  SharedPreferences prefs;
  ProviderLanguage() {
    initSharedPref();
  }

  bool isArabic;
  String local;

  String get getLocal => local;
  bool get isFirstLanguage => isArabic;

  void setLocal(bool isArabic) async {
    this.isArabic = isArabic;
    local = isArabic ? 'ar' : 'fr';
    await prefs.setBool('local', isArabic);
    notifyListeners();
  }

  initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }
}
