import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/routes/routes.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_event.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CategorySelector extends StatefulWidget {
  final String selectedCategoryId;
  final ValueChanged<String>? onCategorySelected;

  const CategorySelector({
    super.key,
    required this.selectedCategoryId,
    this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  @override
  void initState() {
    super.initState();
    getIt<CategoriesBloc>().add(GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.selectedCategoryId,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.translate.categorySelectorValidatorError;
        }
        return null;
      },
      builder: (FormFieldState<String> fieldState) {
        return BlocProvider.value(
          value: getIt<CategoriesBloc>(),
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, categoriesState) {
              if (categoriesState.status == CategoriesStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoriesState.status == CategoriesStatus.success) {
                final categories = categoriesState.categories;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8,
                      ),
                      child: Text(
                        context.translate.categorySelectorTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1,
                              ),
                          itemCount: categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == categories.length) {
                              return GestureDetector(
                                onTap: () {
                                  context.push(addCategoryRoute);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(
                                        FontAwesomeIcons.circlePlus,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      context.translate.add,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }
                            final category = categories[index];
                            return GestureDetector(
                              onTap: () {
                                fieldState.didChange(category.id);
                                if (widget.onCategorySelected != null) {
                                  widget.onCategorySelected!(category.id);
                                }
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: fieldState.value == category.id
                                          ? category.color.withAlpha(50)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: fieldState.value == category.id
                                          ? Border.all(
                                              color: category.color,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: Icon(
                                      category.icon,
                                      color: category.color,
                                    ),
                                  ),
                                  Text(
                                    category.localizedName(context),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (fieldState.hasError)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          fieldState.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const Center(child: Text('Failed to load categories'));
              }
            },
          ),
        );
      },
    );
  }
}
