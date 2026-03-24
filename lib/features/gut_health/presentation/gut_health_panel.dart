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
    if (items.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

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
                Icon(Icons.warning_amber_rounded,
                    color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Text(
                  'Gut Health Alerts',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${items.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _showLogItemDialog(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Log Item'),
                ),
              ],
            ),
            const Divider(),
            // Flagged items
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(
                            _categoryLabel(item.category),
                            style: const TextStyle(fontSize: 11),
                          ),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: _chipColor(item.category, theme),
                        ),
                        if (!item.isAutoFlagged)
                          IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            onPressed: () => onDeleteItem(item.id),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(String category) {
    switch (category) {
      case 'high_sugar':
        return 'High Sugar';
      case 'low_fiber':
        return 'Low Fiber';
      case 'artificial_sweeteners':
        return 'Artificial Sweeteners';
      case 'alcohol':
        return 'Alcohol';
      case 'processed_foods':
        return 'Processed Foods';
      case 'nsaids':
        return 'NSAIDs';
      default:
        return category;
    }
  }

  Color _chipColor(String category, ThemeData theme) {
    switch (category) {
      case 'high_sugar':
        return Colors.orange.withOpacity(0.2);
      case 'low_fiber':
        return Colors.brown.withOpacity(0.2);
      case 'artificial_sweeteners':
        return Colors.purple.withOpacity(0.2);
      case 'alcohol':
        return Colors.red.withOpacity(0.2);
      default:
        return theme.colorScheme.surfaceContainerHighest;
    }
  }

  void _showLogItemDialog(BuildContext context) {
    final manualItems = <String, String>{
      'Artificial sweeteners': 'artificial_sweeteners',
      'Alcohol': 'alcohol',
      'Processed foods': 'processed_foods',
      'NSAIDs': 'nsaids',
      'Fried food': 'processed_foods',
      'Soda / soft drink': 'high_sugar',
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
              children: manualItems.entries.map((entry) {
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
                    category: manualItems[name]!,
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
