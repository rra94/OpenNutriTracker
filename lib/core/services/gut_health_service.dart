import 'package:opennutritracker/core/db/entities/gut_health_item_ob.dart';
import 'package:opennutritracker/core/domain/entity/intake_entity.dart';

class GutHealthService {
  /// Thresholds for auto-flagging
  static const double _highSugarThreshold = 15.0; // g per 100g
  static const double _lowFiberThreshold = 1.0; // g per 100g

  /// Scans a list of intakes and returns auto-flagged gut health items.
  List<GutHealthItemOB> flagFromIntakes(List<IntakeEntity> intakes) {
    final flagged = <GutHealthItemOB>[];

    for (final intake in intakes) {
      final nutriments = intake.meal.nutriments;
      final name = intake.meal.name ?? 'Unknown item';

      // Check high sugar
      final sugars100 = nutriments.sugars100;
      if (sugars100 != null && sugars100 > _highSugarThreshold) {
        flagged.add(GutHealthItemOB(
          name: name,
          category: 'high_sugar',
          dateTime: intake.dateTime,
          isAutoFlagged: true,
          sourceIntakeId: intake.id,
        ));
      }

      // Check low fiber (only if fiber data exists and is non-null)
      final fiber100 = nutriments.fiber100;
      if (fiber100 != null && fiber100 < _lowFiberThreshold) {
        flagged.add(GutHealthItemOB(
          name: name,
          category: 'low_fiber',
          dateTime: intake.dateTime,
          isAutoFlagged: true,
          sourceIntakeId: intake.id,
        ));
      }
    }

    return flagged;
  }
}
