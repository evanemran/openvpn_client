import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatVpnTime(DateTime rawDateTime) {
    final formatter = DateFormat('hh:mm a, dd MMM yyyy');
    return formatter.format(rawDateTime);
  }
}