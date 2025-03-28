import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';

    final now = DateTime.now();
    final isToday = timestamp.day == now.day &&
        timestamp.month == now.month &&
        timestamp.year == now.year;

    return isToday
        ? DateFormat('HH:mm').format(timestamp)
        : DateFormat('dd/MM/yyyy').format(timestamp);
  }
}
