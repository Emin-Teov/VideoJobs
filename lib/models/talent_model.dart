class TalentModel {
  final int id;
  final String user;
  final String title;

  const TalentModel({
    required this.id,
    required this.user,
    required this.title,
  });

  factory TalentModel.fromJson(Map<String, dynamic> json) {
    return TalentModel(
      id: json['id'] as int,
      user: json['user'] as String,
      title: json['title'] as String,
    );
  }
}
