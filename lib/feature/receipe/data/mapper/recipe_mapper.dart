import 'package:recipe_app/feature/receipe/data/model/recipe.dart';
import 'package:recipe_app/feature/receipe/domain/dto/recipe_dto.dart';
import 'ingredient_mapper.dart'; // IngredientDto가 있다면 여기서 toIngredient() 구현

extension RecipeMapper on RecipeDto {
  Recipe toRecipe() {
    return Recipe(
      id: id ?? 0,
      category: category ?? '',
      name: name ?? '',
      image: image ?? '',
      chef: chef ?? '',
      time: time ?? '',
      rating: rating ?? 0.0,
      ingredients:
          ingredients?.map((e) => e.toIngredientAmount()).toList() ?? [],
    );
  }
}
