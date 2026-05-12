import 'package:queue/data/models/localizable.dart';

class Info implements Localizable {
  int number;
  String queueNameRus;
  String queueNameKaz;

  Info({
    required this.number,
    required this.queueNameRus,
    required this.queueNameKaz,
  });

  @override
  String getName(String langCode) {
    return langCode == 'ru' ? queueNameRus : queueNameKaz;
  }

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      number: json['number'],
      queueNameRus: json['queueNameRus'],
      queueNameKaz: json['queueNameKaz'],
    );
  }
}
