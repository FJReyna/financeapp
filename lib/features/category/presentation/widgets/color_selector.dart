import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  MaterialColor? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate.addCategoryColorLabel,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
            mainAxisSpacing: 5,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (final color in Colors.primaries)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _selectedColor == color
                        ? color.withAlpha(50)
                        : color,
                    shape: BoxShape.circle,
                    border: _selectedColor == color
                        ? Border.all(color: color, width: 3)
                        : null,
                  ),
                  child: _selectedColor == color
                      ? Icon(FontAwesomeIcons.check, color: color, size: 16)
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
