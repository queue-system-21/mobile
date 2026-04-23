class Queue {
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

  factory Queue.fromJson(Map<String, dynamic> json) {
    return Queue(
      id: json['id'],
      nameRus: json['nameRus'],
      nameKaz: json['nameKaz'],
      responsibleUserUsername: json['responsibleUserUsername']
    );
  }
}
