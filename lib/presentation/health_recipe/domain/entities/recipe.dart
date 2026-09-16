class Recipe {
  final String id;
  final String name;
  final String? category;
  final String? area;
  final String imageUrl;
  final String? instructions;
  final String? youtubeUrl;

  final List<String> ingredients;
  final List<String> measures;

  const Recipe({
    required this.id,
    required this.name,
    this.category,
    this.area,
    required this.imageUrl,
    this.instructions,
    this.youtubeUrl,
    this.ingredients = const [],
    this.measures = const [],
  });
}
