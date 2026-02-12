import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconSelector extends StatefulWidget {
  final IconData? selectedIcon;
  final ValueChanged<IconData>? onIconSelected;

  const IconSelector({super.key, this.selectedIcon, this.onIconSelected});

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  // Lista de íconos predefinidos comunes
  static final List<IconData> _availableIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.utensils,
    FontAwesomeIcons.car,
    FontAwesomeIcons.film,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.briefcase,
    FontAwesomeIcons.dumbbell,
    FontAwesomeIcons.music,
    FontAwesomeIcons.book,
    FontAwesomeIcons.paintbrush,
    FontAwesomeIcons.mugSaucer,
    FontAwesomeIcons.pizzaSlice,
    FontAwesomeIcons.burger,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.bagShopping,
    FontAwesomeIcons.gift,
    FontAwesomeIcons.suitcaseMedical,
    FontAwesomeIcons.paw,
    FontAwesomeIcons.leaf,
    FontAwesomeIcons.lightbulb,
    FontAwesomeIcons.shirt,
    FontAwesomeIcons.mobile,
    FontAwesomeIcons.computer,
    FontAwesomeIcons.tv,
    FontAwesomeIcons.headphones,
    FontAwesomeIcons.couch,
    FontAwesomeIcons.bicycle,
    FontAwesomeIcons.wineGlass,
    FontAwesomeIcons.wallet,
    FontAwesomeIcons.screwdriverWrench,
    FontAwesomeIcons.baby,
    FontAwesomeIcons.building,
    FontAwesomeIcons.gasPump,
    FontAwesomeIcons.stethoscope,
    FontAwesomeIcons.pills,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.scissors,
    FontAwesomeIcons.seedling,
  ];

  @override
  Widget build(BuildContext context) {
    return FormField<IconData>(
      initialValue: widget.selectedIcon,
      validator: (value) {
        if (value == null) {
          return context.translate.addCategoryIconValidatorError;
        }
        return null;
      },
      builder: (FormFieldState<IconData> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8,
              ),
              child: Text(
                context.translate.addCategoryIconLabel,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1,
                  ),
                  itemCount: _availableIcons.length,
                  itemBuilder: (context, index) {
                    final icon = _availableIcons[index];
                    final isSelected = fieldState.value == icon;

                    return GestureDetector(
                      onTap: () {
                        fieldState.didChange(icon);
                        if (widget.onIconSelected != null) {
                          widget.onIconSelected!(icon);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(50)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                )
                              : Border.all(
                                  color: Colors.grey.withAlpha(50),
                                  width: 1,
                                ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          size: 24,
                        ),
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
      },
    );
  }
}
