extension DateExtension on DateTime {
  toInt() {
    return this.millisecondsSinceEpoch;
  }
}
