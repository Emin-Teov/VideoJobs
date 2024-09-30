class TalentModel {
  final int id;
  final String username;
  final String email;
  final String employment;

  const TalentModel({
    required this.id,
    required this.username,
    required this.email,
    required this.employment,
  });

  factory TalentModel.fromJson(Map<String, dynamic> json) {
    return TalentModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      employment: json['employment'] as String,
    );
  }
}
