import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionDatePicker extends StatefulWidget {
  final ValueChanged<DateTime?>? onDateSelected;

  const TransactionDatePicker({super.key, this.onDateSelected});

  @override
  State<TransactionDatePicker> createState() => _TransactionDatePickerState();
}

class _TransactionDatePickerState extends State<TransactionDatePicker> {
  DateTime initial = DateTime.now();
  DateTime? selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        selected = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (selected != null && widget.onDateSelected != null) {
          widget.onDateSelected!(selected);
          setState(() {
            initial = selected!;
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardTheme.color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                ),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate.date,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      DateFormat(
                        'MMMM dd, yyyy',
                        context.locale.toString(),
                      ).format(selected ?? initial).capitalize(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Icon(FontAwesomeIcons.chevronRight, size: 12),
            ],
          ),
        ),
      ),
    );
  }
}
