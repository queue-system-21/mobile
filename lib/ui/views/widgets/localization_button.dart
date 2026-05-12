import 'package:flutter/material.dart';
import 'package:queue/ui/view_models/localization.view_model.dart';

import '../../view_models/provider.dart';

class LocalizationButton extends StatefulWidget {
  const LocalizationButton({super.key});

  @override
  State<LocalizationButton> createState() => _LocalizationButtonState();
}

class _LocalizationButtonState extends State<LocalizationButton> {

  late LocalizationViewModel _lvm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lvm = Provider.of<LocalizationViewModel>(context);
  }

  String _lang = 'ru';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (_lang == 'ru') {
              _lang = 'en';
            } else if (_lang == 'en') {
              _lang = 'kk';
            } else if (_lang == 'kk') {
              _lang = 'ru';
            } else {
              throw UnimplementedError();
            }
            _lvm.setLocale(_lang);
          });
        },
        child: Text(_lang),
      ),
    );
  }
}
