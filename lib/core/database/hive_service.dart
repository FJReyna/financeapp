import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:finance/hive_registrar.g.dart';

class HiveService {
  static HiveService? _instance;

  static HiveService get instance {
    _instance ??= HiveService._();
    return _instance!;
  }

  HiveService._();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    } else {
      return Hive.box<T>(boxName);
    }
  }

  Future<void> closeAll() async {
    await Hive.close();
  }
}
