import 'package:flutter/material.dart';
import 'package:recipe_app/core/enum/state_enum.dart';
import 'package:recipe_app/feature/receipe/data/repository/recipe_repository_impl.dart';
import 'package:recipe_app/feature/receipe/domain/data_source/mock/mock_recipe_data_source_impl.dart';
import 'package:recipe_app/presentation/pages/base/base_screen.dart';
import 'package:recipe_app/presentation/pages/home/view_model/home_view_model.dart';
import 'package:recipe_app/presentation/widgets/recipe/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = HomeViewModel(RecipeRepositoryImpl(MockRecipeDataSourceImpl()))
      ..fetchRecipes();
    return BaseScreen(
      appBar: AppBar(title: const Text('Saved recipes')),
      child: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          if (vm.state == BaseState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (vm.state == BaseState.error) {
            return const Center(child: Text('에러가 발생하였습니다.'));
          } else if (vm.state == BaseState.moreLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final recipes = vm.recipes;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView.separated(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard.fromModel(recipe);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
            ),
          );
        },
      ),
    );
  }
}
