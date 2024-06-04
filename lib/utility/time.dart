import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Time {
  static String Function(DateTime) dateFormatYmd =
      DateFormat("d'/'M'/'y").format;
  static String Function(DateTime) clockFormatJm = DateFormat.jm().format;
  static DateTime timeNow = DateTime.now();

  static Future<DateTime?> selectDate(BuildContext context) async {
    DateTime now = timeNow;
    DateTime first = DateTime(now.year - 1);
    DateTime last = DateTime(now.year + 1);

    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: first, lastDate: last);
    return pickedDate;
  }
}
