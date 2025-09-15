class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final List<String> dietaryPreferences;
  final List<String> allergies;
  final int age;
  final double height;
  final double weight;
  final String gender;
  final int dailyCalorieGoal;
  final List<String> favoriteRecipes;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.dietaryPreferences = const [],
    this.allergies = const [],
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.dailyCalorieGoal,
    this.favoriteRecipes = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      dietaryPreferences: List<String>.from(json['dietaryPreferences'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
      age: json['age'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      gender: json['gender'],
      dailyCalorieGoal: json['dailyCalorieGoal'],
      favoriteRecipes: List<String>.from(json['favoriteRecipes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'dietaryPreferences': dietaryPreferences,
      'allergies': allergies,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'dailyCalorieGoal': dailyCalorieGoal,
      'favoriteRecipes': favoriteRecipes,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    List<String>? dietaryPreferences,
    List<String>? allergies,
    int? age,
    double? height,
    double? weight,
    String? gender,
    int? dailyCalorieGoal,
    List<String>? favoriteRecipes,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      allergies: allergies ?? this.allergies,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
    );
  }
}