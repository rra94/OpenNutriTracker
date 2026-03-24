import 'package:objectbox/objectbox.dart';

@Entity()
class HabitOB {
  @Id()
  int id = 0;

  String name;
  String category; // skincare, dental, grooming, wellness, exercise, custom
  int sortOrder;
  bool isActive;

  HabitOB({
    this.id = 0,
    required this.name,
    required this.category,
    this.sortOrder = 0,
    this.isActive = true,
  });
}
