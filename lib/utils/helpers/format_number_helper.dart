import 'package:intl/intl.dart';

class FormatNumberHelper {
  static String formatNumber(int number) {
    final formattedNumber = NumberFormat('#,###', 'vi').format(number);
    return formattedNumber;
  }
}