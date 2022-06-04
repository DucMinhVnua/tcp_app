import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';

/*
  DateTime.parse(String input) just accept input format same:
  "2012-02-27"
  "2012-02-27 13:27:00"
  "2012-02-27 13:27:00.123456789z"
  "2012-02-27 13:27:00,123456789z"
  "20120227 13:27:00"
  "20120227T132700"
  "20120227"
  "+20120227"
  "2012-02-27T14Z"
  "2012-02-27T14+00:00"
  "-123450101 00:00:00 Z": in the year -12345.
  "2002-02-27T14:00:00-0500": Same as "2002-02-27T19:00:00Z"
  NOT accept:
  18-11-2020
  Nov, 20 2020
  19/11/2020
  12/30/2020
 */

extension StringExtension on String {
  get firstLetterToUpperCase {
    if (this != null)
      return this[0].toUpperCase() + this.substring(1);
    else
      return null;
  }

  String getFirstChar() {
    return (this[0] ?? "").toLowerCase();
  }

  bool get isNullOrEmpty {
    return (this == null || this.isEmpty);
  }

  bool get isNotNullOrEmpty {
    return !this.isNullOrEmpty;
  }

  Color toColor() {
    if (this.isNullOrEmpty) {
      return Color(int.parse("0xffffff"));
    }
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return Color(int.parse("0xffffff"));
  }

  DateTime toDate() {
    if (this.isNullOrEmpty) {
      return DateTime.now();
    }
    return DateTime.parse(this);
  }

  String toDateTimeFormat({String format = Constant.ddMMyyyyHHmm}) {
    if (this.isNullOrEmpty) {
      return "";
    }
    return "${DateFormat(format).format(DateTime.parse(this))}";
  }

  String toFullDateTimeFormat({String format = Constant.ddMMyyyyHHmmss}) {
    if (this.isNullOrEmpty) {
      return "";
    }
    return "${DateFormat(format).format(DateTime.parse(this))}";
  }

  String toDateFormat(
      {String formatString, String format = Constant.ddMMyyyy}) {
    if (this.isNullOrEmpty) {
      return "";
    }
    if (num.tryParse(this) != null)
      return "${DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(int.parse(this)))}";
    return "${DateFormat(format).format(DateTime.parse(this))}";
  }

  String toTimeFormat({String format = Constant.HHmm}) {
    if (this.isNullOrEmpty) {
      return "";
    }
    return "${DateFormat(format).format(DateTime.parse(this))}";
  }

  // regex for email
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  // regex for phone
  bool isPhone() {
    return RegExp(r"^[0-9]{10,11}$").hasMatch(this);
  }
}
