class CategoryModel {
  final int id;
  final int index;
  final double number;
  final String title;
  final List children;

  const CategoryModel({
    required this.id,
    required this.index,
    required this.number,
    required this.title,
    required this.children,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      index: json['index'] as int,
      number: json['number'] as double,
      title: json['title'] as String,
      children: json['children'] as List,
    );
  }
}
