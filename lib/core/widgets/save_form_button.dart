import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaveFormButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function()? onPressed;

  const SaveFormButton({super.key, required this.formKey, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (onPressed != null) {
            onPressed!();
          }
        }
      },
      icon: Icon(FontAwesomeIcons.floppyDisk),
      label: Text(context.translate.save),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
