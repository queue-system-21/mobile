class Info {
  int number;
  String queueNameRus;
  String queueNameKaz;

  Info({
    required this.number,
    required this.queueNameRus,
    required this.queueNameKaz,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      number: json['number'],
      queueNameRus: json['queueNameRus'],
      queueNameKaz: json['queueNameKaz'],
    );
  }
}
