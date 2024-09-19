class OfferModel {
  final int id;
  final int employer_id;
  final String employment;
  final String ceo;
  final bool video;
  final String description;

  const OfferModel({
    required this.id,
    required this.employer_id,
    required this.employment,
    required this.ceo,
    required this.video,
    required this.description,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as int,
      employer_id: json['employer_id'] as int,
      employment: json['employment'] as String,
      ceo: json['ceo'] as String,
      video: json['video'] as bool,
      description: json['description'] as String,
    );
  }
}