// lib/utils/date_formatter.dart
import 'package:intl/intl.dart';

String formatDateTime(DateTime dt, {String pattern = 'EEE, MMM d'}) {
  return DateFormat(pattern).format(dt);
}
