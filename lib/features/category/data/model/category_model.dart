import 'package:finance/features/category/domain/entites/category.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int icon;
  @HiveField(3)
  final int color;
  @HiveField(4)
  final String iconFontFamily;
  @HiveField(5)
  final String iconFontPackage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.iconFontFamily,
    required this.iconFontPackage,
  });

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      icon: category.icon.codePoint,
      color: category.color.toARGB32(),
      iconFontFamily: category.icon.fontFamily ?? '',
      iconFontPackage: category.icon.fontPackage ?? '',
    );
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      icon: IconData(
        icon,
        fontFamily: iconFontFamily,
        fontPackage: iconFontPackage,
      ),
      color: Color.fromARGB(
        (color >> 24) & 0xFF,
        (color >> 16) & 0xFF,
        (color >> 8) & 0xFF,
        color & 0xFF,
      ),
    );
  }
}
