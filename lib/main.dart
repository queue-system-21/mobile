import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:queue/data/repos/queue.repo.dart';
import 'package:queue/ui/view_models/localization.view_model.dart';
import 'package:queue/ui/view_models/provider.dart';
import 'package:queue/ui/view_models/queue.view_model.dart';
import 'package:queue/ui/views/screens/sign_in.dart';

import 'l10n/app_localizations.dart';

void main() {
  runApp(
    Provider(
      notifier: QueueViewModel(repo: QueueRepo()),
      child: Provider(notifier: LocalizationViewModel(), child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dotenv.load(fileName: ".env");
    return MaterialApp(
      title: 'Flutter Demo',
      home: SignIn(),
      locale: Provider.of<LocalizationViewModel>(context).locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
