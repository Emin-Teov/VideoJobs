class JobSeekerModel {
  final int id;
  final String name;
  final String surname;
  final String title;

  const JobSeekerModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.title,
  });

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) {
    return JobSeekerModel(
      id: json['id'] as int,
      title: json['title'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
    );
  }
}
