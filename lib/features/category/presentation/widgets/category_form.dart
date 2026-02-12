import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/util/validators.dart';
import 'package:finance/features/category/presentation/widgets/color_selector.dart';
import 'package:finance/features/category/presentation/widgets/icon_selector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  late TextEditingController _nameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              context.translate.addCategoryNameLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              validator: (value) => Validators.validateNotEmpty(value, context),
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                fillColor: Theme.of(context).cardTheme.color,
                filled: true,
              ),
            ),
            SizedBox(height: 32),
            ColorSelector(),
            SizedBox(height: 32),
            IconSelector(),
            SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              icon: Icon(FontAwesomeIcons.floppyDisk),
              label: Text(context.translate.save),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
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
