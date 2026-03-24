import 'package:flutter/material.dart';
import 'package:opennutritracker/core/db/entities/habit_ob.dart';

class HabitsChecklistWidget extends StatelessWidget {
  final List<HabitOB> habits;
  final Set<int> completedHabitIds;
  final void Function(int habitId, bool completed) onToggle;

  const HabitsChecklistWidget({
    super.key,
    required this.habits,
    required this.completedHabitIds,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedCount = completedHabitIds.length;
    final totalCount = habits.length;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.checklist, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Daily Habits',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: completedCount == totalCount
                        ? Colors.green.withOpacity(0.2)
                        : theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$completedCount/$totalCount',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: completedCount == totalCount
                          ? Colors.green
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Placeholder for manage action
                  },
                  child: const Text('Manage'),
                ),
              ],
            ),
            const Divider(),
            // Habit list
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  final isCompleted = completedHabitIds.contains(habit.id);
                  return CheckboxListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      habit.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: isCompleted
                            ? theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.5)
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      habit.category,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.textTheme.labelSmall?.color
                            ?.withOpacity(0.6),
                      ),
                    ),
                    value: isCompleted,
                    onChanged: (value) =>
                        onToggle(habit.id, value ?? false),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
