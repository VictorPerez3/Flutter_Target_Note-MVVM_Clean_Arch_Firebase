import 'dart:math';

class IdGenerator {
  static String generateId() {
    final random = Random();
    return (random.nextInt(90000) + 10000).toString();
  }
}
