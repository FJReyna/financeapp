import 'package:finance/core/dependency_injection.dart';
import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/util/validators.dart';
import 'package:finance/core/widgets/save_form_button.dart';
import 'package:finance/features/category/domain/entites/category.dart';
import 'package:finance/features/category/presentation/bloc/category_bloc.dart';
import 'package:finance/features/category/presentation/bloc/category_event.dart';
import 'package:finance/features/category/presentation/bloc/category_state.dart';
import 'package:finance/features/category/presentation/widgets/color_selector.dart';
import 'package:finance/features/category/presentation/widgets/icon_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  Color? _selectedColor;
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (context) => getIt<CategoryBloc>(),
      child: BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state.status == CategoryStatus.success) {
            Navigator.of(context).pop(true);
          } else if (state.status == CategoryStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error')),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    context.translate.addCategoryNameLabel,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    validator: (value) =>
                        Validators.validateNotEmpty(value, context),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).cardTheme.color,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ColorSelector(
                  selectedColor: _selectedColor,
                  onColorSelected: (color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                ),
                SizedBox(height: 32),
                IconSelector(
                  selectedIcon: _selectedIcon,
                  iconColor:
                      _selectedColor ?? Theme.of(context).colorScheme.primary,
                  onIconSelected: (icon) {
                    _selectedIcon = icon;
                  },
                ),
                SizedBox(height: 32),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (BuildContext context, CategoryState state) {
                    if (state.status == CategoryStatus.loading) {
                      return CircularProgressIndicator();
                    } else {
                      return SaveFormButton(
                        formKey: _formKey,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final category = Category(
                              id: '',
                              name: _nameController.text.trim(),
                              color: _selectedColor!,
                              icon: _selectedIcon!,
                            );
                            context.read<CategoryBloc>().add(
                              AddCategoryEvent(category),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }
}
