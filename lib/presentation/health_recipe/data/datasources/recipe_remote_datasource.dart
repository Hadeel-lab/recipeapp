import '../../../../core/network/dio_client.dart';
import '../models/recipe_model.dart';

class RecipeRemoteDataSource {
  final DioClient dioClient;

  RecipeRemoteDataSource({required this.dioClient});

  Future<List<RecipeModel>> getRecipes() async {
    final response = await dioClient.dio.get(
      '/search.php',
      queryParameters: {'f': 'a'},
    );

    // مؤقتًا حتى نتأكد أن الـ API يرجع البيانات
    print(response.data);

    final data = response.data;

    if (data == null || data['meals'] == null) {
      return [];
    }

    final List meals = data['meals'];

    return meals
        .map((meal) => RecipeModel.fromJson(meal as Map<String, dynamic>))
        .toList();
  }
}
