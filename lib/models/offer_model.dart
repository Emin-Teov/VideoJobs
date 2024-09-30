class OfferModel {
  final int id;
  final int employer;
  final String email;
  final String employment;
  final String ceo;
  final String description;

  const OfferModel({
    required this.id,
    required this.employer,
    required this.email,
    required this.employment,
    required this.ceo,
    required this.description,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as int,
      employer: json['employer'] as int,
      email: json['email'] as String,
      employment: json['employment'] as String,
      ceo: json['ceo'] as String,
      description: json['description'] as String,
    );
  }
}
