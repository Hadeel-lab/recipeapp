import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_recipes.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipes getRecipes;

  RecipeBloc({required this.getRecipes}) : super(RecipeInitial()) {
    on<GetRecipesEvent>(_onGetRecipes);
  }

  Future<void> _onGetRecipes(
    GetRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipeLoading());

    try {
      final recipes = await getRecipes();

      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }
}
