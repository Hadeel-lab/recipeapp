import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_datasource.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource dataSource;

  RecipeRepositoryImpl(this.dataSource);

  @override
  Future<List<Recipe>> getRecipes() async {
    return await dataSource.getRecipes();
  }
}
