import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:opennutritracker/features/add_meal/domain/entity/meal_nutriments_entity.dart';

part 'meal_nutriments_dbo.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class MealNutrimentsDBO extends HiveObject {
  @HiveField(0)
  final double? energyKcal100;
  @HiveField(1)
  final double? carbohydrates100;
  @HiveField(2)
  final double? fat100;
  @HiveField(3)
  final double? proteins100;
  @HiveField(4)
  final double? sugars100;
  @HiveField(5)
  final double? saturatedFat100;
  @HiveField(6)
  final double? fiber100;

  // Micronutrients - Minerals
  @HiveField(7)
  final double? sodium100;
  @HiveField(8)
  final double? potassium100;
  @HiveField(9)
  final double? calcium100;
  @HiveField(10)
  final double? iron100;
  @HiveField(11)
  final double? magnesium100;
  @HiveField(12)
  final double? phosphorus100;
  @HiveField(13)
  final double? zinc100;
  @HiveField(14)
  final double? copper100;
  @HiveField(15)
  final double? manganese100;
  @HiveField(16)
  final double? selenium100;

  // Micronutrients - Vitamins
  @HiveField(17)
  final double? vitaminA100;
  @HiveField(18)
  final double? vitaminC100;
  @HiveField(19)
  final double? vitaminD100;
  @HiveField(20)
  final double? vitaminE100;
  @HiveField(21)
  final double? vitaminK100;
  @HiveField(22)
  final double? thiamine100;
  @HiveField(23)
  final double? riboflavin100;
  @HiveField(24)
  final double? niacin100;
  @HiveField(25)
  final double? pantothenicAcid100;
  @HiveField(26)
  final double? vitaminB6100;
  @HiveField(27)
  final double? folate100;
  @HiveField(28)
  final double? vitaminB12100;

  // Other
  @HiveField(29)
  final double? cholesterol100;
  @HiveField(30)
  final double? addedSugars100;

  MealNutrimentsDBO({
    required this.energyKcal100,
    required this.carbohydrates100,
    required this.fat100,
    required this.proteins100,
    required this.sugars100,
    required this.saturatedFat100,
    required this.fiber100,
    this.sodium100,
    this.potassium100,
    this.calcium100,
    this.iron100,
    this.magnesium100,
    this.phosphorus100,
    this.zinc100,
    this.copper100,
    this.manganese100,
    this.selenium100,
    this.vitaminA100,
    this.vitaminC100,
    this.vitaminD100,
    this.vitaminE100,
    this.vitaminK100,
    this.thiamine100,
    this.riboflavin100,
    this.niacin100,
    this.pantothenicAcid100,
    this.vitaminB6100,
    this.folate100,
    this.vitaminB12100,
    this.cholesterol100,
    this.addedSugars100,
  });

  factory MealNutrimentsDBO.fromProductNutrimentsEntity(
      MealNutrimentsEntity nutriments) {
    return MealNutrimentsDBO(
      energyKcal100: nutriments.energyKcal100,
      carbohydrates100: nutriments.carbohydrates100,
      fat100: nutriments.fat100,
      proteins100: nutriments.proteins100,
      sugars100: nutriments.sugars100,
      saturatedFat100: nutriments.saturatedFat100,
      fiber100: nutriments.fiber100,
      sodium100: nutriments.sodium100,
      potassium100: nutriments.potassium100,
      calcium100: nutriments.calcium100,
      iron100: nutriments.iron100,
      magnesium100: nutriments.magnesium100,
      phosphorus100: nutriments.phosphorus100,
      zinc100: nutriments.zinc100,
      copper100: nutriments.copper100,
      manganese100: nutriments.manganese100,
      selenium100: nutriments.selenium100,
      vitaminA100: nutriments.vitaminA100,
      vitaminC100: nutriments.vitaminC100,
      vitaminD100: nutriments.vitaminD100,
      vitaminE100: nutriments.vitaminE100,
      vitaminK100: nutriments.vitaminK100,
      thiamine100: nutriments.thiamine100,
      riboflavin100: nutriments.riboflavin100,
      niacin100: nutriments.niacin100,
      pantothenicAcid100: nutriments.pantothenicAcid100,
      vitaminB6100: nutriments.vitaminB6100,
      folate100: nutriments.folate100,
      vitaminB12100: nutriments.vitaminB12100,
      cholesterol100: nutriments.cholesterol100,
      addedSugars100: nutriments.addedSugars100,
    );
  }

  factory MealNutrimentsDBO.fromJson(Map<String, dynamic> json) =>
      _$MealNutrimentsDBOFromJson(json);

  Map<String, dynamic> toJson() => _$MealNutrimentsDBOToJson(this);
}
