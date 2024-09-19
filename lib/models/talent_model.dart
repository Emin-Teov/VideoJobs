class TalentModel {
  final int id;
  final String user;
  final String employment;

  const TalentModel({
    required this.id,
    required this.user,
    required this.employment,
  });

  factory TalentModel.fromJson(Map<String, dynamic> json) {
    return TalentModel(
      id: json['id'] as int,
      user: json['user'] as String,
      employment: json['employment'] as String,
    );
  }
}
