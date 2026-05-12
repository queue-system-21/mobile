import 'package:flutter/material.dart';
import 'package:queue/data/models/localizable.dart';
import 'package:queue/ui/view_models/localization.view_model.dart';

import '../../view_models/provider.dart';

class LocalizeText extends StatefulWidget {

  final Localizable data;

  const LocalizeText(this.data, {super.key});

  @override
  State<LocalizeText> createState() => _LocalizeTextState();
}

class _LocalizeTextState extends State<LocalizeText> {

  late LocalizationViewModel _lvm;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lvm = Provider.of<LocalizationViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.data.getName(_lvm.locale.languageCode));
  }
}