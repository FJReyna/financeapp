import 'package:flutter/material.dart';

class CategoryBreakdownLinearIndicator extends StatelessWidget {
  final Color color;
  final double value;
  final IconData icon;
  final String title;

  const CategoryBreakdownLinearIndicator({
    super.key,
    required this.color,
    required this.value,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(15),
                minHeight: 15,
                value: value,
                color: color,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha(50),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
