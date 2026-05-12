import 'package:queue/data/models/localizable.dart';

class Queue implements Localizable {
  int? id;
  String nameRus;
  String nameKaz;
  String? responsibleUserUsername;

  Queue({
    this.id,
    required this.nameRus,
    required this.nameKaz,
    this.responsibleUserUsername,
  });

  @override
  String getName(String langCode) {
    return langCode == 'ru' ? nameRus : nameKaz;
  }

  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      id: json['id'],
      nameRus: json['nameRus'],
      nameKaz: json['nameKaz'],
      responsibleUserUsername: json['responsibleUserUsername']
    );
  }
}
