import 'package:flutter/material.dart';
import 'package:opennutritracker/core/db/entities/gut_health_item_ob.dart';

class GutHealthPanel extends StatelessWidget {
  final List<GutHealthItemOB> items;
  final void Function(GutHealthItemOB item) onAddManualItem;
  final void Function(int id) onDeleteItem;

  const GutHealthPanel({
    super.key,
    required this.items,
    required this.onAddManualItem,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final autoItems = items.where((i) => i.isAutoFlagged).toList();
    final manualItems = items.where((i) => !i.isAutoFlagged).toList();
    final hasItems = items.isNotEmpty;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header — always visible
            Row(
              children: [
                Icon(
                  hasItems ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                  color: hasItems ? theme.colorScheme.error : Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  'Gut Health',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (hasItems) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${items.length} bad',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showLogItemDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Log'),
                ),
              ],
            ),

            // Status message
            if (!hasItems)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'No gut-harmful items consumed today',
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.green),
                ),
              ),

            // Today's bad items consumed
            if (hasItems) ...[
              const Divider(),

              // Auto-detected from food
              if (autoItems.isNotEmpty) ...[
                Text(
                  'Detected from meals:',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: autoItems.map((item) => Chip(
                    avatar: Icon(_categoryIcon(item.category), size: 16),
                    label: Text(
                      '${item.name} — ${_categoryLabel(item.category)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: _chipColor(item.category, theme),
                  )).toList(),
                ),
              ],

              // Manually logged
              if (manualItems.isNotEmpty) ...[
                if (autoItems.isNotEmpty) const SizedBox(height: 8),
                Text(
                  'Manually logged:',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: manualItems.map((item) => Chip(
                    avatar: Icon(_categoryIcon(item.category), size: 16),
                    label: Text(item.name, style: const TextStyle(fontSize: 12)),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: _chipColor(item.category, theme),
                    deleteIcon: const Icon(Icons.close, size: 14),
                    onDeleted: () => onDeleteItem(item.id),
                  )).toList(),
                ),
              ],

              // Daily summary
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _buildSummary(autoItems, manualItems),
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _buildSummary(List<GutHealthItemOB> auto, List<GutHealthItemOB> manual) {
    final parts = <String>[];

    // Count by category
    final categoryCounts = <String, int>{};
    for (final item in [...auto, ...manual]) {
      final label = _categoryLabel(item.category);
      categoryCounts[label] = (categoryCounts[label] ?? 0) + 1;
    }

    for (final entry in categoryCounts.entries) {
      if (entry.value > 1) {
        parts.add('${entry.value}x ${entry.key}');
      } else {
        parts.add(entry.key);
      }
    }

    return 'Today: ${parts.join(', ')}';
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'high_sugar': return Icons.cake_outlined;
      case 'low_fiber': return Icons.grass;
      case 'artificial_sweeteners': return Icons.science_outlined;
      case 'alcohol': return Icons.local_bar_outlined;
      case 'processed_foods': return Icons.fastfood_outlined;
      case 'nsaids': return Icons.medication_outlined;
      default: return Icons.warning_amber;
    }
  }

  String _categoryLabel(String category) {
    switch (category) {
      case 'high_sugar': return 'High Sugar';
      case 'low_fiber': return 'Low Fiber';
      case 'artificial_sweeteners': return 'Artificial Sweeteners';
      case 'alcohol': return 'Alcohol';
      case 'processed_foods': return 'Processed Foods';
      case 'nsaids': return 'NSAIDs';
      case 'fried_foods': return 'Fried Foods';
      case 'emulsifiers': return 'Emulsifiers';
      case 'artificial_coloring': return 'Artificial Coloring';
      default: return category;
    }
  }

  Color _chipColor(String category, ThemeData theme) {
    switch (category) {
      case 'high_sugar': return Colors.orange.withValues(alpha: 0.2);
      case 'low_fiber': return Colors.brown.withValues(alpha: 0.2);
      case 'artificial_sweeteners': return Colors.purple.withValues(alpha: 0.2);
      case 'alcohol': return Colors.red.withValues(alpha: 0.2);
      case 'processed_foods': return Colors.grey.withValues(alpha: 0.2);
      case 'nsaids': return Colors.blue.withValues(alpha: 0.2);
      case 'fried_foods': return Colors.amber.withValues(alpha: 0.2);
      default: return theme.colorScheme.surfaceContainerHighest;
    }
  }

  void _showLogItemDialog(BuildContext context) {
    final manualItemOptions = <String, String>{
      'Artificial sweeteners': 'artificial_sweeteners',
      'Alcohol': 'alcohol',
      'Processed foods': 'processed_foods',
      'NSAIDs (ibuprofen, etc.)': 'nsaids',
      'Fried food': 'fried_foods',
      'Soda / soft drink': 'high_sugar',
      'Emulsifiers': 'emulsifiers',
      'Artificial coloring': 'artificial_coloring',
      'Excess refined sugar': 'high_sugar',
      'Energy drink': 'artificial_sweeteners',
    };

    final selected = <String>{};

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Log Gut-Harmful Items'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: manualItemOptions.entries.map((entry) {
                return CheckboxListTile(
                  dense: true,
                  title: Text(entry.key),
                  value: selected.contains(entry.key),
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        selected.add(entry.key);
                      } else {
                        selected.remove(entry.key);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                for (final name in selected) {
                  onAddManualItem(GutHealthItemOB(
                    name: name,
                    category: manualItemOptions[name]!,
                    dateTime: DateTime.now(),
                    isAutoFlagged: false,
                  ));
                }
                Navigator.of(ctx).pop();
              },
              child: const Text('Log'),
            ),
          ],
        ),
      ),
    );
  }
}
