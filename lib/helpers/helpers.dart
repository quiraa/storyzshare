import 'package:intl/intl.dart';

class Helpers {
  static String formatDate(String rawDate) {
    DateTime dateTime = DateTime.parse(rawDate);
    final DateFormat formatter = DateFormat('EEEE, d MMM yyyy HH:mm:ss');
    return formatter.format(dateTime);
  }
}
