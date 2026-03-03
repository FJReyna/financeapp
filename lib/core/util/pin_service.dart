import 'dart:convert';
import 'package:crypto/crypto.dart';

class PinService {
  static String hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verifyPin(String pin, String storedHash) {
    final inputHash = hashPin(pin);
    return inputHash == storedHash;
  }

  static bool isValidPin(String pin) {
    if (pin.length < 4 || pin.length > 6) {
      return false;
    }
    return RegExp(r'^\d+$').hasMatch(pin);
  }
}
