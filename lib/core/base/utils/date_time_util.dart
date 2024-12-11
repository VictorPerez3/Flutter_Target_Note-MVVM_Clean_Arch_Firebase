import 'package:intl/intl.dart';

class DateTimeUtil {
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  static String formatDateNoteDetails(DateTime date) {
    return DateFormat('EEEE, MMMM d, y').format(date);
  }

  static String formatDateNoteMenu(DateTime date) {
    return DateFormat('MMM. dd, yyyy').format(date);
  }
}
