import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/custom_picker.dart';

class DateTimePickerWidget {
  BuildContext context;
  String format;
  Function(String) onDateTimeSelected;
  String currentTime;
  DateTime maxTime;
  DateTime minTime; // DateTime.now()

  DateTimePickerWidget(
      {@required this.context,
      @required this.format,
      @required this.onDateTimeSelected,
      this.currentTime,
      this.maxTime,
      this.minTime});

  Future<void> showOnlyDatePicker() async {
    if (format.isEmpty) {
      format = Constant.ddMMyyyy;
    }
    DatePicker.showDatePicker(
      context,
      locale: LocaleType.vi,
      showTitleActions: true,
      maxTime: maxTime,
      minTime: minTime,
      // currentTime: this.currentTime?.toDate(format: format) ?? DateTime.now(),
      onConfirm: (date) {
        String formattedDate = DateFormat(format).format(date);
        onDateTimeSelected(formattedDate);
      },
    );
  }

  Future<void> showOnlyTimePicker() async {
    // hàm này chỉ dùng để hiển thị hh:mm (giờ phút)
    if (format.isEmpty) {
      format = Constant.HHmm;
    }
    DatePicker.showPicker(context,
        showTitleActions: true,
        locale: LocaleType.vi,
        pickerModel: CustomPicker(
            currentTime: this.currentTime?.toDateFormat(format: format) ??
                DateTime.now()), onConfirm: (date) {
      String formattedDate = DateFormat(format).format(date);
      onDateTimeSelected(formattedDate);
    });
  }

  Future<void> showPicker() async {
    // hàm này chỉ dùng để hiển thị hh:mm (giờ phút)
    DatePicker.showPicker(context,
        showTitleActions: true,
        locale: LocaleType.vi,
        pickerModel: CustomPicker(
            currentTime: this.currentTime?.toDateFormat(format: format) ??
                DateTime.now()), onConfirm: (date) {
      String formattedDate = DateFormat(format).format(date);
      onDateTimeSelected(formattedDate);
    });
  }

  Future<void> showDateTimePicker() async {
    if (format.isEmpty) {
      format = Constant.ddMMyyyy2;
    }
    DatePicker.showDateTimePicker(context,
        minTime: minTime,
        locale: LocaleType.vi,
        showTitleActions: true,
        maxTime: maxTime,
        // currentTime: this.currentTime?.toDate(format: format) ?? DateTime.now(),
        onConfirm: (date) {
      String formattedDate = DateFormat(format).format(date);
      onDateTimeSelected(formattedDate);
    });
  }
}
