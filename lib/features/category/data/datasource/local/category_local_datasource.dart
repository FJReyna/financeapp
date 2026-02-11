import 'package:finance/core/dependency_injection.dart';
import 'package:finance/features/category/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:uuid/uuid.dart';

class CategoryLocalDatasource {
  final Box<CategoryModel> box;

  CategoryLocalDatasource(this.box);

  Future<List<CategoryModel>> getAll() async {
    return box.values.toList();
  }

  Future<void> add(CategoryModel category) async {
    await box.put(category.id, category);
  }

  Future<void> delete(String id) async {
    await box.delete(id);
  }

  Future<List<String>> seed() async {
    Uuid uuid = getIt<Uuid>();

    List<String> categoryIds = [];

    IconData houseIconData = FontAwesomeIcons.house;
    IconData utensilsIconData = FontAwesomeIcons.utensils;
    IconData carIconData = FontAwesomeIcons.car;
    IconData filmIconData = FontAwesomeIcons.film;
    IconData plusIconData = FontAwesomeIcons.plus;

    if (box.isEmpty) {
      final defaultCategories = [
        CategoryModel(
          id: uuid.v4(),
          name: 'Housing',
          icon: FontAwesomeIcons.house.codePoint,
          color: Colors.blue.toARGB32(),
          iconFontFamily: houseIconData.fontFamily ?? '',
          iconFontPackage: houseIconData.fontPackage ?? '',
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Food & Drinking',
          icon: FontAwesomeIcons.utensils.codePoint,
          color: Colors.orange.toARGB32(),
          iconFontFamily: utensilsIconData.fontFamily ?? '',
          iconFontPackage: utensilsIconData.fontPackage ?? '',
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Transportation',
          icon: carIconData.codePoint,
          color: Colors.purple.toARGB32(),
          iconFontFamily: carIconData.fontFamily ?? '',
          iconFontPackage: carIconData.fontPackage ?? '',
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Entertainment',
          icon: filmIconData.codePoint,
          color: Colors.pink.toARGB32(),
          iconFontFamily: filmIconData.fontFamily ?? '',
          iconFontPackage: filmIconData.fontPackage ?? '',
        ),
        CategoryModel(
          id: uuid.v4(),
          name: 'Other',
          icon: plusIconData.codePoint,
          color: Colors.teal.toARGB32(),
          iconFontFamily: plusIconData.fontFamily ?? '',
          iconFontPackage: plusIconData.fontPackage ?? '',
        ),
      ];

      for (var category in defaultCategories) {
        await add(category);
        categoryIds.add(category.id);
      }
    }
    return categoryIds;
  }
}
