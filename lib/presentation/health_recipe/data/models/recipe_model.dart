import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel({
    required super.id,
    required super.name,
    super.category,
    super.area,
    required super.imageUrl,
    super.instructions,
    super.youtubeUrl,
    super.ingredients,
    super.measures,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final List<String> ingredients = [];
    final List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient.toString().trim());

        measures.add(measure?.toString().trim() ?? '');
      }
    }

    return RecipeModel(
      id: json['idMeal']?.toString() ?? '',
      name: json['strMeal']?.toString() ?? '',
      category: json['strCategory']?.toString(),
      area: json['strArea']?.toString(),
      imageUrl: json['strMealThumb']?.toString() ?? '',
      instructions: json['strInstructions']?.toString(),
      youtubeUrl: json['strYoutube']?.toString(),
      ingredients: ingredients,
      measures: measures,
    );
  }
}
