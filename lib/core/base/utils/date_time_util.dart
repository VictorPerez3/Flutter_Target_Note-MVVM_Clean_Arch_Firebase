import 'package:intl/intl.dart';

class DateTimeUtil {
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  static String formatDate(DateTime date) {
    return DateFormat('EEEE, MMMM d, y').format(date);
  }
}
