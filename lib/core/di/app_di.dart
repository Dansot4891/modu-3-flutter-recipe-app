import 'package:get_it/get_it.dart';
import 'package:recipe_app/feature/receipe/data/data_source/home/mock/mock_recipe_data_source_impl.dart';
import 'package:recipe_app/feature/receipe/data/data_source/home/recipe_data_source.dart';
import 'package:recipe_app/feature/receipe/data/data_source/info/mock/mock_recipe_info_data_source_impl.dart';
import 'package:recipe_app/feature/receipe/data/data_source/info/recipe_info_data_source.dart';
import 'package:recipe_app/feature/receipe/data/data_source/search/mock/mock_search_recipe_data_source_impl.dart';
import 'package:recipe_app/feature/receipe/data/data_source/search/search_recipe_data_source.dart';
import 'package:recipe_app/feature/receipe/data/repository/home/recipe_repository_impl.dart';
import 'package:recipe_app/feature/receipe/data/repository/info/recipe_info_repository_impl.dart';
import 'package:recipe_app/feature/receipe/data/repository/search/search_recipe_repository_impl.dart';
import 'package:recipe_app/feature/receipe/domain/repository/home/recipe_repository.dart';
import 'package:recipe_app/feature/receipe/domain/repository/info/recipe_info_repository.dart';
import 'package:recipe_app/feature/receipe/domain/repository/search/search_recipe_repository.dart';
import 'package:recipe_app/feature/receipe/domain/use_case/info/get_recipe_info_use_case.dart';
import 'package:recipe_app/feature/receipe/domain/use_case/saved_recipes/bookmark_recipes_use_case.dart';
import 'package:recipe_app/feature/receipe/domain/use_case/saved_recipes/get_saved_recipes_use_case.dart';
import 'package:recipe_app/feature/receipe/presentation/info/recipe_info_view_model.dart';
import 'package:recipe_app/feature/receipe/presentation/saved_recipes/saved_recipes_view_model.dart';
import 'package:recipe_app/feature/receipe/presentation/search_recipes/search_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // 데이터 소스
  getIt.registerSingleton<RecipeDataSource>(MockRecipeDataSourceImpl());
  getIt.registerSingleton<SearchRecipeDataSource>(
    MockSearchRecipeDataSourceImpl(),
  );
  getIt.registerSingleton<RecipeInfoDataSource>(MockRecipeInfoDataSourceImpl());

  // 레포지토리
  getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(getIt()));
  getIt.registerSingleton<RecipeInfoRepository>(
    RecipeInfoRepositoryImpl(getIt()),
  );
  getIt.registerSingleton<SearchRecipeRepository>(
    SearchRecipeRepositoryImpl(getIt()),
  );

  // 유스케이스
  getIt.registerSingleton(GetRecipeInfoUseCase(getIt()));
  getIt.registerSingleton(GetSavedRecipesUseCase(getIt()));
  getIt.registerSingleton(BookmarkRecipesUseCase(getIt()));

  // 뷰모델
  getIt.registerFactory(
    () => SavedRecipesViewModel(
      bookmarkRecipesUseCase: getIt(),
      getSavedRecipesUseCase: getIt(),
    ),
  );
  getIt.registerFactory(() => RecipeInfoViewModel(getIt()));
  getIt.registerFactory(() => SearchViewModel(getIt()));
}
