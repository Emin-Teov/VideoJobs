class DataModel {
  final List<dynamic> categories;
  final List<dynamic> countries;
  final List<dynamic> job_seekers;
  final List<dynamic> offers;
   final List<dynamic> freelancers;

  const DataModel({
    required this.categories,
    required this.countries,
    required this.job_seekers,
    required this.offers,
    required this.freelancers,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      categories: json['categories'] as List,
      countries: json['countries'] as List,
      job_seekers: json['job_seekers'] as List,
      offers: json['offers'] as List,
      freelancers: json['freelancers'] as List,
    );
  }
}