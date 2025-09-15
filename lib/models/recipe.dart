import 'ingredient.dart';
import 'nutrition_info.dart';
class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> categories;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final NutritionInfo nutritionInfo;
  final int prepTime;
  final int cookTime;
  final int servings;
  final double rating;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.categories,
    required this.ingredients,
    required this.instructions,
    required this.nutritionInfo,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.rating,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      categories: List<String>.from(json['categories']),
      ingredients: (json['ingredients'] as List).map((i) => Ingredient.fromJson(i)).toList(),
      instructions: List<String>.from(json['instructions']),
      nutritionInfo: NutritionInfo.fromJson(json['nutritionInfo']),
      prepTime: json['prepTime'],
      cookTime: json['cookTime'],
      servings: json['servings'],
      rating: json['rating'].toDouble(),
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'categories': categories,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'instructions': instructions,
      'nutritionInfo': nutritionInfo.toJson(),
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'rating': rating,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isGlutenFree': isGlutenFree,
    };
  }
}