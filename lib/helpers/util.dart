import 'package:date_format/date_format.dart';

class Util {
  static bool isNullOrEmpty(String value) {
    return value == null || value.isEmpty;
  }

  static String showDateTime(DateTime data, String noDate) {
    if (data == null) {
      return noDate ?? "";
    } else {
      return formatDate(
          data, [dd, '-', mm, '-', yyyy, ' ', HH, ':', nn, ':', ss]);
    }
  }
}
