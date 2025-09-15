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
        title: 'Quinoa Salad Bowl',
        description: 'A healthy and refreshing quinoa salad with vegetables and herbs.',
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
        categories: ['Healthy', 'Vegetarian', 'Gluten-Free'],
        ingredients: [
          Ingredient(name: 'Quinoa', quantity: 1, unit: 'cup'),
          Ingredient(name: 'Cherry tomatoes', quantity: 1, unit: 'cup'),
          Ingredient(name: 'Cucumber', quantity: 1, unit: 'piece'),
          Ingredient(name: 'Feta cheese', quantity: 0.5, unit: 'cup'),
        ],
        instructions: [
          'Cook quinoa according to package instructions.',
          'Chop vegetables and mix with cooked quinoa.',
          'Add feta cheese and dressing.',
          'Serve chilled.',
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
        title: 'Grilled Chicken Breast',
        description: 'Juicy grilled chicken breast with herbs and spices.',
        imageUrl: 'https://images.unsplash.com/photo-1532636618426-7eab5e9f4d6e?w=400',
        categories: ['Protein', 'Grilled', 'Low-Carb'],
        ingredients: [
          Ingredient(name: 'Chicken breast', quantity: 2, unit: 'pieces'),
          Ingredient(name: 'Olive oil', quantity: 2, unit: 'tbsp'),
          Ingredient(name: 'Garlic', quantity: 2, unit: 'cloves'),
          Ingredient(name: 'Rosemary', quantity: 1, unit: 'tsp'),
        ],
        instructions: [
          'Marinate chicken with oil, garlic, and herbs.',
          'Preheat grill to medium-high heat.',
          'Grill chicken for 6-7 minutes per side.',
          'Let rest before serving.',
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