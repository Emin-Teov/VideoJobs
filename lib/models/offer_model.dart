class OfferModel {
  final int id;
  final String title;
  final String ceo;
  final String description;

  const OfferModel({
    required this.id,
    required this.title,
    required this.ceo,
    required this.description,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as int,
      title: json['title'] as String,
      ceo: json['ceo'] as String,
      description: json['description'] as String,
    );
  }
}