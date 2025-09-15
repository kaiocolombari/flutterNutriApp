import 'nutrition_info.dart';
class Ingredient {
  final String name;
  final double quantity;
  final String unit;
  final NutritionInfo? nutritionInfo;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    this.nutritionInfo,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'].toDouble(),
      unit: json['unit'],
      nutritionInfo: json['nutritionInfo'] != null ? NutritionInfo.fromJson(json['nutritionInfo']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'nutritionInfo': nutritionInfo?.toJson(),
    };
  }
}