class JobSeekerModel {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String employment;

  const JobSeekerModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.employment,
  });

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) {
    return JobSeekerModel(
      id: json['id'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      employment: json['employment'] as String,
    );
  }
}
