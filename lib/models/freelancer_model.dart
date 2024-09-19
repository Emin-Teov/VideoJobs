class FreelancerModel {
  final int id;
  final String user;
  final String employment;

  const FreelancerModel({
    required this.id,
    required this.user,
    required this.employment,
  });

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    return FreelancerModel(
      id: json['id'] as int,
      user: json['user'] as String,
      employment: json['employment'] as String,
    );
  }
}
