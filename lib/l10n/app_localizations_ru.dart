// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get signingIn => 'Вход';

  @override
  String get signingUp => 'Регистраиця';

  @override
  String get username => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get toSignIn => 'Войти';

  @override
  String get toSignUp => 'Зарегистрироваться';

  @override
  String get successfulSignIn => 'Вы успешно авторизовались';

  @override
  String get successfulSignUp => 'Вы успешно зарегистрировались';

  @override
  String get nameRus => 'Имя (рус)';

  @override
  String get nameKaz => 'Имя (каз)';

  @override
  String get responsibleUser => 'Ответственный пользователь';

  @override
  String get save => 'Сохранить';

  @override
  String get fillAllFields => 'Заполните все поля';

  @override
  String get error => 'Ошибка';

  @override
  String get queue => 'Очередь';

  @override
  String get queueNumber => 'Номер в очереди';
}
