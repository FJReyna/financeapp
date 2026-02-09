import 'package:finance/core/database/hive_box_names.dart';
import 'package:finance/core/database/hive_service.dart';
import 'package:finance/features/category/data/datasource/local/category_local_datasource.dart';
import 'package:finance/features/category/data/model/category_model.dart';
import 'package:finance/features/category/data/repository/category_repository_impl.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/category/domain/usecases/get_top_categories.dart';
import 'package:finance/features/stats/presentation/bloc/stats_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:uuid/uuid.dart';

GetIt getIt = GetIt.instance;

Future<void> setup() async {
  final HiveService hiveService = HiveService.instance;
  await hiveService.init();

  getIt.registerSingleton<Uuid>(Uuid());

  await openAndRegisterBoxes(hiveService);
  await setUpCategories();

  getIt.registerFactory<StatsBloc>(() => StatsBloc(getIt<GetTopCategories>()));
}

Future<void> openAndRegisterBoxes(HiveService hiveService) async {
  final categoryBox = await hiveService.openBox<CategoryModel>(
    HiveBoxNames.categories,
  );
  getIt.registerSingleton<Box<CategoryModel>>(categoryBox);
}

Future<void> setUpCategories() async {
  CategoryLocalDatasource categoryLocalDatasource = CategoryLocalDatasource(
    getIt<Box<CategoryModel>>(),
  );

  if (kDebugMode) {
    await categoryLocalDatasource.seed();
  }

  getIt.registerLazySingleton<CategoryLocalDatasource>(
    () => categoryLocalDatasource,
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<CategoryLocalDatasource>()),
  );

  getIt.registerLazySingleton<GetTopCategories>(
    () => GetTopCategories(getIt<CategoryRepository>()),
  );
}
