import 'package:finance/core/util/extensions.dart';
import 'package:flutter/material.dart';

class Validators {
  static String? validateNotEmpty(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return context.translate.emptyFieldError;
    }
    return null;
  }

  static String? validateAmount(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return context.translate.emptyAmountError;
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return context.translate.validAmountError;
    }
    return null;
  }
}
