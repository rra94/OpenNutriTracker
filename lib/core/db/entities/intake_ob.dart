import 'package:objectbox/objectbox.dart';

@Entity()
class IntakeOB {
  @Id()
  int id = 0;

  @Unique()
  String intakeId;

  String unit;
  double amount;

  /// 0=breakfast, 1=lunch, 2=dinner, 3=snack
  int intakeType;

  @Property(type: PropertyType.date)
  DateTime dateTime;

  // ---------------------------------------------------------------------------
  // Meal fields (flattened from MealDBO)
  // ---------------------------------------------------------------------------
  String? code;
  String? name;
  String? brands;
  String? thumbnailImageUrl;
  String? mainImageUrl;
  String? url;
  String? mealQuantity;
  String? mealUnit;
  double? servingQuantity;
  String? servingUnit;
  String? servingSize;

  /// 0=unknown, 1=custom, 2=off, 3=fdc
  int mealSource;

  // ---------------------------------------------------------------------------
  // Nutriments fields (flattened from MealNutrimentsDBO)
  // ---------------------------------------------------------------------------
  double? energyKcal100;
  double? carbohydrates100;
  double? fat100;
  double? proteins100;
  double? sugars100;
  double? saturatedFat100;
  double? fiber100;

  IntakeOB({
    this.id = 0,
    required this.intakeId,
    required this.unit,
    required this.amount,
    required this.intakeType,
    required this.dateTime,
    this.code,
    this.name,
    this.brands,
    this.thumbnailImageUrl,
    this.mainImageUrl,
    this.url,
    this.mealQuantity,
    this.mealUnit,
    this.servingQuantity,
    this.servingUnit,
    this.servingSize,
    this.mealSource = 0,
    this.energyKcal100,
    this.carbohydrates100,
    this.fat100,
    this.proteins100,
    this.sugars100,
    this.saturatedFat100,
    this.fiber100,
  });
}
