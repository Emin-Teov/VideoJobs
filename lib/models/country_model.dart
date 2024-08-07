class CountryModel {
  final int id;
  final String code;
  final String title;

  const CountryModel({
    required this.id,
    required this.code,
    required this.title,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as int,
      code: json['code'] as String,
      title: json['title'] as String,
    );
  }
}
