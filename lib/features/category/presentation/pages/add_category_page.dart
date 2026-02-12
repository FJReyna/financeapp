import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/widgets/bottom_nav_bar.dart';
import 'package:finance/features/category/presentation/widgets/category_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.translate.addCategoryTitle),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft),
        ),
      ),
      body: Center(child: CategoryForm()),
      bottomNavigationBar: Hero(
        tag: 'bottom_nav_bar',
        child: BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
