import 'package:finance/core/dependency_injection.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_bloc.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_event.dart';
import 'package:finance/features/transactions/presentation/bloc/categories/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesBloc>()..add(GetCategoriesEvent()),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == CategoriesStatus.success) {
            final categories = state.categories;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 8,
                  ),
                  child: Text(
                    'Category',
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
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            if (widget.onCategorySelected != null) {
                              widget.onCategorySelected!(category.id);
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color:
                                      widget.selectedCategoryId == category.id
                                      ? category.color.withAlpha(50)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border:
                                      widget.selectedCategoryId == category.id
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
                                category.name,
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
              ],
            );
          } else {
            return const Center(child: Text('Failed to load categories'));
          }
        },
      ),
    );
  }
}
