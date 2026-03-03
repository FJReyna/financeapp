import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorSelector extends StatefulWidget {
  final Color? selectedColor;
  final ValueChanged<Color>? onColorSelected;

  const ColorSelector({super.key, this.selectedColor, this.onColorSelected});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  @override
  Widget build(BuildContext context) {
    return FormField<Color>(
      initialValue: widget.selectedColor,
      validator: (value) {
        if (value == null) {
          return context.translate.addCategoryColorValidatorError;
        }
        return null;
      },
      builder: (FormFieldState<Color> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Text(
                context.translate.addCategoryColorLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
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
                          fieldState.didChange(color);
                          if (widget.onColorSelected != null) {
                            widget.onColorSelected!(color);
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: fieldState.value == color
                                ? color.withAlpha(50)
                                : color,
                            shape: BoxShape.circle,
                            border: fieldState.value == color
                                ? Border.all(color: color, width: 3)
                                : null,
                          ),
                          child: fieldState.value == color
                              ? Icon(
                                  FontAwesomeIcons.check,
                                  color: color,
                                  size: 16,
                                )
                              : null,
                        ),
                      ),
                  ],
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
      },
    );
  }
}
