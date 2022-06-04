import 'package:intl/intl.dart';

extension IntExtension on int {
  //API Trả về 0 hoặc null nếu chưa có time => Hiển thị rỗng
  toDate(String format) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(this);
    if (this == 0) {
      return "";
    } else {
      return DateFormat(format).format(dateToTimeStamp);
    }
  }
}
