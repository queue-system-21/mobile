// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get signingIn => 'Кіре беріс';

  @override
  String get signingUp => 'Тіркеме';

  @override
  String get username => 'Қолданушының аты';

  @override
  String get password => 'Пароль';

  @override
  String get toSignIn => 'Кіру';

  @override
  String get toSignUp => 'Тіркелу';

  @override
  String get successfulSignIn => 'Авторизация сәтті өтті';

  @override
  String get successfulSignUp => 'Тіркелу сәтті өтті';
}
