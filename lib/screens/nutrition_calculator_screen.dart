import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_service.dart';
import '../models/models.dart';

class NutritionCalculatorScreen extends StatefulWidget {
  const NutritionCalculatorScreen({super.key});

  @override
  State<NutritionCalculatorScreen> createState() => _NutritionCalculatorScreenState();
}

class _NutritionCalculatorScreenState extends State<NutritionCalculatorScreen> {
  final TextEditingController _mealController = TextEditingController();
  List<Ingredient> _mealIngredients = [];
  NutritionInfo _totalNutrition = NutritionInfo(calories: 0, protein: 0, carbs: 0, fat: 0);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final user = userService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Nutricional'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null) ...[
              _buildUserStats(user, userService),
              const SizedBox(height: 24),
            ],
            const Text(
              'Calculadora de Refeições',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _mealController,
              decoration: const InputDecoration(
                labelText: 'Adicionar ingrediente (ex: 100g peito de frango)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addIngredient,
              child: const Text('Adicionar Ingrediente'),
            ),
            const SizedBox(height: 24),
            if (_mealIngredients.isNotEmpty) ...[
              const Text(
                'Ingredientes da Refeição',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._mealIngredients.map((ingredient) => _buildIngredientItem(ingredient)),
              const SizedBox(height: 24),
              _buildNutritionSummary(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUserStats(User user, UserService userService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suas Estatísticas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem('IMC', userService.calculateBMI().toStringAsFixed(1)),
                ),
                Expanded(
                  child: _buildStatItem('TMB', '${userService.calculateBMR()} cal'),
                ),
                Expanded(
                  child: _buildStatItem('Meta', '${user.dailyCalorieGoal} cal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    return Card(
      child: ListTile(
        title: Text(ingredient.name),
        subtitle: Text('${ingredient.quantity} ${ingredient.unit}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _removeIngredient(ingredient),
        ),
      ),
    );
  }

  Widget _buildNutritionSummary() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nutrição Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildNutritionRow('Calorias', '${_totalNutrition.calories.toStringAsFixed(0)} kcal'),
            _buildNutritionRow('Proteína', '${_totalNutrition.protein.toStringAsFixed(1)}g'),
            _buildNutritionRow('Carboidratos', '${_totalNutrition.carbs.toStringAsFixed(1)}g'),
            _buildNutritionRow('Gordura', '${_totalNutrition.fat.toStringAsFixed(1)}g'),
            if (_totalNutrition.fiber > 0)
              _buildNutritionRow('Fibra', '${_totalNutrition.fiber.toStringAsFixed(1)}g'),
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
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _addIngredient() {
    final input = _mealController.text.trim();
    if (input.isEmpty) return;

    final ingredient = Ingredient(
      name: input,
      quantity: 100,
      unit: 'g',
      nutritionInfo: NutritionInfo(
        calories: 150,
        protein: 25,
        carbs: 0,
        fat: 5,
      ),
    );

    setState(() {
      _mealIngredients.add(ingredient);
      _totalNutrition = _totalNutrition + ingredient.nutritionInfo!;
    });

    _mealController.clear();
  }

  void _removeIngredient(Ingredient ingredient) {
    setState(() {
      _mealIngredients.remove(ingredient);
      _totalNutrition = _totalNutrition + ingredient.nutritionInfo!.multiply(-1);
    });
  }

  @override
  void dispose() {
    _mealController.dispose();
    super.dispose();
  }
}