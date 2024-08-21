class FreelancerModel {
  final int id;
  final String user;
  final String title;

  const FreelancerModel({
    required this.id,
    required this.user,
    required this.title,
  });

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    return FreelancerModel(
      id: json['id'] as int,
      user: json['user'] as String,
      title: json['title'] as String,
    );
  }
}
