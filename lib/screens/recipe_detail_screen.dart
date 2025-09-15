import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/models.dart';
import '../services/recipe_service.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final recipeService = Provider.of<RecipeService>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: recipe.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  recipeService.isFavorite(recipe.id) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () => recipeService.toggleFavorite(recipe.id),
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => _addToShoppingList(context, recipe),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(Icons.timer, '${recipe.prepTime + recipe.cookTime} min'),
                      const SizedBox(width: 16),
                      _buildInfoChip(Icons.people, '${recipe.servings} servings'),
                      const SizedBox(width: 16),
                      _buildInfoChip(Icons.star, recipe.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: recipe.categories.map((category) =>
                      Chip(label: Text(category))
                    ).toList(),
                  ),
                  const SizedBox(height: 24),
                  _buildSection('Ingredients', _buildIngredients()),
                  const SizedBox(height: 24),
                  _buildSection('Instructions', _buildInstructions()),
                  const SizedBox(height: 24),
                  _buildSection('Nutrition Facts', _buildNutrition()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildIngredients() {
    return Column(
      children: recipe.ingredients.map((ingredient) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20),
              const SizedBox(width: 12),
              Text(
                '${ingredient.quantity} ${ingredient.unit} ${ingredient.name}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        )
      ).toList(),
    );
  }

  Widget _buildInstructions() {
    return Column(
      children: recipe.instructions.asMap().entries.map((entry) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.green,
                child: Text(
                  '${entry.key + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        )
      ).toList(),
    );
  }

  Widget _buildNutrition() {
    final nutrition = recipe.nutritionInfo;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildNutritionRow('Calories', '${nutrition.calories} kcal'),
            _buildNutritionRow('Protein', '${nutrition.protein}g'),
            _buildNutritionRow('Carbohydrates', '${nutrition.carbs}g'),
            _buildNutritionRow('Fat', '${nutrition.fat}g'),
            if (nutrition.fiber > 0) _buildNutritionRow('Fiber', '${nutrition.fiber}g'),
            if (nutrition.sugar > 0) _buildNutritionRow('Sugar', '${nutrition.sugar}g'),
            if (nutrition.sodium > 0) _buildNutritionRow('Sodium', '${nutrition.sodium}mg'),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  void _addToShoppingList(BuildContext context, Recipe recipe) {
    // In a real app, this would add to a persistent shopping list
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${recipe.title} ingredients to shopping list'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Navigate to shopping list screen (not implemented)
          },
        ),
      ),
    );
  }
}
