import 'package:finance/core/database/hive_box_names.dart';
import 'package:finance/core/database/hive_service.dart';
import 'package:finance/features/category/data/datasource/local/category_local_datasource.dart';
import 'package:finance/features/category/data/model/category_model.dart';
import 'package:finance/features/category/data/repository/category_repository_impl.dart';
import 'package:finance/features/category/domain/repository/category_repository.dart';
import 'package:finance/features/category/domain/usecases/add_category.dart';
import 'package:finance/features/category/domain/usecases/get_all_categories.dart';
import 'package:finance/features/category/domain/usecases/get_top_categories.dart';
import 'package:finance/features/category/presentation/bloc/category_bloc.dart';
import 'package:finance/features/settings/data/datasource/local/settings_local_datasource.dart';
import 'package:finance/features/settings/data/model/app_settings_model.dart';
import 'package:finance/features/settings/data/repository/settings_repository_impl.dart';
import 'package:finance/features/settings/domain/repository/settings_repository.dart';
import 'package:finance/features/settings/domain/usecase/get_settings.dart';
import 'package:finance/features/settings/domain/usecase/save_settings.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/stats/presentation/bloc/stats_bloc.dart';
import 'package:finance/features/transactions/data/datasource/transaction_local_datasource.dart';
import 'package:finance/features/transactions/data/model/transaction_model.dart';
import 'package:finance/features/transactions/data/repository/transaction_repository_impl.dart';
import 'package:finance/features/transactions/domain/repository/transaction_repository.dart';
import 'package:finance/features/transactions/domain/usecase/add_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/delete_transaction.dart';
import 'package:finance/features/transactions/domain/usecase/get_all_transactions.dart';
import 'package:finance/features/transactions/domain/usecase/get_transaction.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/transactions/transactions_bloc.dart';
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
  List<String> categoryIds = await setUpCategories();
  await setUpTransactions(categoryIds);
  await setUpSettings();
  await setUpBlocs();
}

Future<void> openAndRegisterBoxes(HiveService hiveService) async {
  final categoryBox = await hiveService.openBox<CategoryModel>(
    HiveBoxNames.categories,
  );
  getIt.registerSingleton<Box<CategoryModel>>(categoryBox);

  final transactionBox = await hiveService.openBox<TransactionModel>(
    HiveBoxNames.transactions,
  );
  getIt.registerSingleton<Box<TransactionModel>>(transactionBox);

  final settingsBox = await hiveService.openBox<AppSettingsModel>(
    HiveBoxNames.settings,
  );
  getIt.registerSingleton<Box<AppSettingsModel>>(settingsBox);
}

Future<void> setUpBlocs() async {
  getIt.registerFactory<StatsBloc>(() => StatsBloc(getIt<GetTopCategories>()));
  getIt.registerLazySingleton<TransactionsBloc>(
    () => TransactionsBloc(
      getIt<GetAllTransactions>(),
      getIt<GetTransaction>(),
      getIt<AddTransaction>(),
      getIt<DeleteTransaction>(),
    ),
  );

  getIt.registerSingleton<SettingsBloc>(
    SettingsBloc(getIt<GetSettings>(), getIt<SaveSettings>()),
  );

  getIt.registerLazySingleton<CategoriesBloc>(
    () => CategoriesBloc(getIt<GetAllCategories>()),
  );

  getIt.registerFactory<CategoryBloc>(() => CategoryBloc(getIt<AddCategory>()));
}

Future<void> setUpSettings() async {
  Box<AppSettingsModel> settingsBox = getIt<Box<AppSettingsModel>>();

  getIt.registerLazySingleton<SettingsLocalDatasource>(
    () => SettingsLocalDatasource(settingsBox),
  );

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDatasource>()),
  );

  getIt.registerLazySingleton<GetSettings>(
    () => GetSettings(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<SaveSettings>(
    () => SaveSettings(getIt<SettingsRepository>()),
  );
}

Future<void> setUpTransactions(List<String> categoryIds) async {
  Box<TransactionModel> transactionBox = getIt<Box<TransactionModel>>();

  TransactionLocalDatasource transactionLocalDatasource =
      TransactionLocalDatasource(transactionBox);

  if (kDebugMode && transactionBox.isEmpty) {
    await transactionLocalDatasource.seed(categoryIds);
  }

  getIt.registerLazySingleton<TransactionLocalDatasource>(
    () => transactionLocalDatasource,
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      localDatasource: getIt<TransactionLocalDatasource>(),
    ),
  );

  getIt.registerLazySingleton<GetAllTransactions>(
    () => GetAllTransactions(
      getIt<TransactionRepository>(),
      getIt<CategoryRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetTransaction>(
    () => GetTransaction(getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<AddTransaction>(
    () => AddTransaction(getIt<TransactionRepository>()),
  );

  getIt.registerLazySingleton<DeleteTransaction>(
    () => DeleteTransaction(getIt<TransactionRepository>()),
  );
}

Future<List<String>> setUpCategories() async {
  List<String> categoryIds = [];
  Box<CategoryModel> categoryBox = getIt<Box<CategoryModel>>();

  CategoryLocalDatasource categoryLocalDatasource = CategoryLocalDatasource(
    categoryBox,
  );

  if (categoryBox.isEmpty) {
    categoryIds = await categoryLocalDatasource.seed();
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

  getIt.registerLazySingleton<GetAllCategories>(
    () => GetAllCategories(getIt<CategoryRepository>()),
  );

  getIt.registerLazySingleton<AddCategory>(
    () => AddCategory(getIt<CategoryRepository>()),
  );

  return categoryIds;
}
