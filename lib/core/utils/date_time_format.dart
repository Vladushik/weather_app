import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatTime(DateTime time) => DateFormat('HH:mm').format(time);
  static String formatTimeHm(DateTime time) => DateFormat.Hm().format(time);
  static String formatDate(DateTime date) =>
      DateFormat('EEE, d MMM').format(date);

  //July 28 15:00
  static String formatDateMDHM(DateTime date) =>
      DateFormat('MMMMd').add_Hm().format(date);
}
