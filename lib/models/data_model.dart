class DataModel {
  final List categories;
  final List countries;
  final List job_seekers;
  final List offers;
  final List freelancers;
  final List talents;

  const DataModel({
    required this.categories,
    required this.countries,
    required this.job_seekers,
    required this.offers,
    required this.freelancers,
    required this.talents,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      categories: json['categories'] as List,
      countries: json['countries'] as List,
      job_seekers: json['job_seekers'] as List,
      offers: json['offers'] as List,
      freelancers: json['freelancers'] as List,
      talents: json['talents'] as List,
    );
  }
}