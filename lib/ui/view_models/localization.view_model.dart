import 'dart:ui';

import 'package:flutter/foundation.dart';

class LocalizationViewModel extends ChangeNotifier {

  Locale _locale = Locale('ru', '');

  Locale get locale => _locale;

  void setLocale(String langCode) {
    _locale = Locale(langCode, '');
    notifyListeners();
  }

}