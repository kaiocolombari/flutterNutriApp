import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/models.dart';

class UserService extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  UserService() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson != null) {
        _currentUser = User.fromJson(json.decode(userJson));
      } else {
        // Create default user
        _currentUser = User(
          id: '1',
          name: 'João Silva',
          email: 'joao@example.com',
          age: 30,
          height: 175.0,
          weight: 70.0,
          gender: 'Masculino',
          dailyCalorieGoal: 2000,
        );
        await _saveUser();
      }
    } catch (e) {
      print('Error loading user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveUser() async {
    if (_currentUser == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', json.encode(_currentUser!.toJson()));
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  Future<void> updateUser(User updatedUser) async {
    _currentUser = updatedUser;
    await _saveUser();
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    int? age,
    double? height,
    double? weight,
    String? gender,
    int? dailyCalorieGoal,
  }) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(
      name: name,
      email: email,
      age: age,
      height: height,
      weight: weight,
      gender: gender,
      dailyCalorieGoal: dailyCalorieGoal,
    );

    await _saveUser();
    notifyListeners();
  }

  Future<void> addFavoriteRecipe(String recipeId) async {
    if (_currentUser == null) return;

    final favorites = List<String>.from(_currentUser!.favoriteRecipes);
    if (!favorites.contains(recipeId)) {
      favorites.add(recipeId);
      _currentUser = _currentUser!.copyWith(favoriteRecipes: favorites);
      await _saveUser();
      notifyListeners();
    }
  }

  Future<void> removeFavoriteRecipe(String recipeId) async {
    if (_currentUser == null) return;

    final favorites = List<String>.from(_currentUser!.favoriteRecipes);
    favorites.remove(recipeId);
    _currentUser = _currentUser!.copyWith(favoriteRecipes: favorites);
    await _saveUser();
    notifyListeners();
  }

  bool isRecipeFavorite(String recipeId) {
    return _currentUser?.favoriteRecipes.contains(recipeId) ?? false;
  }

  double calculateBMI() {
    if (_currentUser == null) return 0.0;

    final heightInMeters = _currentUser!.height / 100;
    return _currentUser!.weight / (heightInMeters * heightInMeters);
  }

  String getBMICategory() {
    final bmi = calculateBMI();
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  int calculateBMR() {
    if (_currentUser == null) return 0;

    // Mifflin-St Jeor Equation
    final weight = _currentUser!.weight;
    final height = _currentUser!.height;
    final age = _currentUser!.age;
    final isMale = _currentUser!.gender.toLowerCase() == 'male';

    if (isMale) {
      return (10 * weight + 6.25 * height - 5 * age + 5).round();
    } else {
      return (10 * weight + 6.25 * height - 5 * age - 161).round();
    }
  }
}