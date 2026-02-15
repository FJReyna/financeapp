import 'package:flutter/widgets.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String? nameKey;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.nameKey,
  });

  Category copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    String? nameKey,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      nameKey: nameKey ?? this.nameKey,
    );
  }
}
