import 'package:flutter/foundation.dart';
import '../models/models.dart';

class RecipeService extends ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> _favoriteRecipes = [];

  List<Recipe> get recipes => _recipes;
  List<Recipe> get favoriteRecipes => _favoriteRecipes;

  RecipeService() {
    _loadSampleData();
  }

  void _loadSampleData() {
    _recipes = [
      Recipe(
        id: '1',
        title: 'Salada de Quinoa',
        description: 'Uma salada saudável e refrescante de quinoa com vegetais e ervas.',
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
        categories: ['Saudável', 'Vegetariano', 'Sem Glúten'],
        ingredients: [
          Ingredient(name: 'Quinoa', quantity: 1, unit: 'xícara'),
          Ingredient(name: 'Tomates cereja', quantity: 1, unit: 'xícara'),
          Ingredient(name: 'Pepino', quantity: 1, unit: 'unidade'),
          Ingredient(name: 'Queijo feta', quantity: 0.5, unit: 'xícara'),
        ],
        instructions: [
          'Cozinhe a quinoa de acordo com as instruções da embalagem.',
          'Pique os vegetais e misture com a quinoa cozida.',
          'Adicione queijo feta e molho.',
          'Sirva gelado.',
        ],
        nutritionInfo: NutritionInfo(
          calories: 320,
          protein: 12,
          carbs: 45,
          fat: 14,
          fiber: 6,
        ),
        prepTime: 15,
        cookTime: 20,
        servings: 2,
        rating: 4.5,
        isVegetarian: true,
        isVegan: false,
        isGlutenFree: true,
      ),
      Recipe(
        id: '2',
        title: 'Peito de Frango Grelhado',
        description: 'Peito de frango suculento grelhado com ervas e especiarias.',
        imageUrl: 'https://images.unsplash.com/photo-1532636618426-7eab5e9f4d6e?w=400',
        categories: ['Proteína', 'Grelhado', 'Baixo Carboidrato'],
        ingredients: [
          Ingredient(name: 'Peito de frango', quantity: 2, unit: 'peças'),
          Ingredient(name: 'Azeite de oliva', quantity: 2, unit: 'colheres de sopa'),
          Ingredient(name: 'Alho', quantity: 2, unit: 'dentes'),
          Ingredient(name: 'Alecrim', quantity: 1, unit: 'colher de chá'),
        ],
        instructions: [
          'Marinar o frango com óleo, alho e ervas.',
          'Pré-aqueça a grelha em fogo médio-alto.',
          'Grelhe o frango por 6-7 minutos de cada lado.',
          'Deixe descansar antes de servir.',
        ],
        nutritionInfo: NutritionInfo(
          calories: 280,
          protein: 35,
          carbs: 2,
          fat: 12,
          fiber: 0,
        ),
        prepTime: 10,
        cookTime: 15,
        servings: 2,
        rating: 4.2,
        isVegetarian: false,
        isVegan: false,
        isGlutenFree: true,
      ),
    ];
    notifyListeners();
  }

  List<Recipe> searchRecipes(String query) {
    return _recipes.where((recipe) =>
      recipe.title.toLowerCase().contains(query.toLowerCase()) ||
      recipe.description.toLowerCase().contains(query.toLowerCase()) ||
      recipe.categories.any((category) => category.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }

  List<Recipe> filterRecipes({
    List<String>? categories,
    bool? isVegetarian,
    bool? isVegan,
    bool? isGlutenFree,
    double? maxCalories,
  }) {
    return _recipes.where((recipe) {
      if (categories != null && categories.isNotEmpty) {
        if (!categories.any((category) => recipe.categories.contains(category))) {
          return false;
        }
      }
      if (isVegetarian != null && recipe.isVegetarian != isVegetarian) return false;
      if (isVegan != null && recipe.isVegan != isVegan) return false;
      if (isGlutenFree != null && recipe.isGlutenFree != isGlutenFree) return false;
      if (maxCalories != null && recipe.nutritionInfo.calories > maxCalories) return false;
      return true;
    }).toList();
  }

  void toggleFavorite(String recipeId) {
    final recipe = _recipes.firstWhere((r) => r.id == recipeId);
    if (_favoriteRecipes.contains(recipe)) {
      _favoriteRecipes.remove(recipe);
    } else {
      _favoriteRecipes.add(recipe);
    }
    notifyListeners();
  }

  bool isFavorite(String recipeId) {
    return _favoriteRecipes.any((r) => r.id == recipeId);
  }
}