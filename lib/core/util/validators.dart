class Validators {
  static String? validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount cannot be empty';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount greater than zero';
    }
    return null;
  }
}
