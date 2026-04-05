import 'package:intl/intl.dart';

class AppDateUtils {
  static String todayKey() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  static String formatArabicDate(DateTime date) {
    return DateFormat('EEEE, d MMMM yyyy', 'ar').format(date);
  }
}
