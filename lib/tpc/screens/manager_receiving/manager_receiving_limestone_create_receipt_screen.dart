import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/extension/list.dart';
import 'package:workflow_manager/base/ui/date_time_picker_widget.dart';
import 'package:workflow_manager/base/utils/app_constant.dart';
import 'package:workflow_manager/base/utils/file_utils.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/manager_receiving_limestone_model.dart';
import 'package:workflow_manager/models/response/list_require_supply_limestone_response.dart';
import 'package:workflow_manager/storage/utils/ImageUtils.dart';
import 'package:workflow_manager/tpc/models/response/upload_response.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class ManagerReceivingLimestoneCreateReceiptScreen extends StatefulWidget {
  @override
  _ManagerReceivingLimestoneCreateReceiptScreenState createState() =>
      _ManagerReceivingLimestoneCreateReceiptScreenState();
}

class _ManagerReceivingLimestoneCreateReceiptScreenState
    extends State<ManagerReceivingLimestoneCreateReceiptScreen> {
  TextEditingController requireNoTextController = TextEditingController();
  TextEditingController requireDateTextController = TextEditingController();
  TextEditingController requireLimestoneSheetTextController =
      TextEditingController();

  // Validate
  bool requireNoValidation = false;
  bool requireDateValidation = false;
  bool requireLimestoneSheetValidation = false;

  DanhSachPhieuYeuCauCapDaVoi sheetSelected;

  List<UploadModel> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManagerReceivingLimestoneModel>(context, listen: false)
          .createReceipt();
    });
  }

  @override
  void dispose() {
    requireNoTextController.dispose();
    requireDateTextController.dispose();
    requireLimestoneSheetTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tạo mới tiếp nhận hồ sơ"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Huỷ",
                  style: kDefaultTextStyle.copyWith(color: Colors.white)),
              // style: TextButton.styleFrom(primary: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ManagerReceivingLimestoneModel>(
          builder: (_, model, __) => (model == null ||
                  model.listRequireSupplyLimestone == null ||
                  model.listRequireSupplyLimestone
                          .danhSachPhieuYeuCauCapDaVoi ==
                      null)
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Số yêu cầu',
                              style: kSmallGreyTextStyle,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '*',
                              style: kSmallGreyTextStyle.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: requireNoTextController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kGrey1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kBlue1),
                            ),
                            labelStyle: kDefaultTextStyle,
                            isDense: true,
                            contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                            errorText: requireNoValidation
                                ? 'Số yêu cầu không được để trống'
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 16.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Ngày gửi yêu cầu',
                              style: kSmallGreyTextStyle,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '*',
                              style: kSmallGreyTextStyle.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: requireDateTextController,
                          readOnly: true,
                          onTap: () {
                            DateTimePickerWidget(
                                    context: context,
                                    format: Constant.ddMMyyyyHHmm2,
                                    onDateTimeSelected: (value) {
                                      setState(() {
                                        requireDateTextController.text = value;
                                      });
                                    },
                                    maxTime: DateTime.now()
                                        .add(const Duration(days: 30)),
                                    minTime: DateTime.now()
                                        .add(const Duration(days: -30)))
                                .showDateTimePicker();
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kGrey1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kBlue1),
                            ),
                            labelStyle: kDefaultTextStyle,
                            isDense: true,
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 16.3, minWidth: 17),
                            suffixIcon: SvgImage(svgName: 'ic_date_picker'),
                            contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                            errorText: requireDateValidation
                                ? 'Ngày gửi yêu cầu không được để trống'
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 16.0, right: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Phiếu yêu cầu đá vôi',
                              style: kSmallGreyTextStyle,
                            ),
                            SizedBox(width: 2),
                            Text(
                              '*',
                              style: kSmallGreyTextStyle.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DropdownSearch<DanhSachPhieuYeuCauCapDaVoi>(
                          mode: Mode.BOTTOM_SHEET,
                          dropdownButtonBuilder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: SvgImage(
                                svgName: 'ic_dropdown',
                                size: 6.0,
                              ),
                            );
                          },
                          items: model.listRequireSupplyLimestone
                              .danhSachPhieuYeuCauCapDaVoi,
                          itemAsString: (DanhSachPhieuYeuCauCapDaVoi sheet) =>
                              sheet.text,
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kGrey1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kBlue1),
                            ),
                            labelStyle: kDefaultTextStyle,
                            isDense: true,
                            errorText: requireLimestoneSheetValidation
                                ? 'Phiếu yêu cầu không được để trống'
                                : null,
                          ),
                          onChanged: (DanhSachPhieuYeuCauCapDaVoi sheet) {
                            requireLimestoneSheetTextController.text =
                                sheet.text;
                            sheetSelected = sheet;
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            enableSuggestions: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              contentPadding: EdgeInsets.all(8.0),
                              hintText: 'Tìm kiếm phiếu yêu cầu',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 16.0, right: 20.0),
                        child: Text(
                          'Tài liệu đính kèm',
                          style: kSmallGreyTextStyle.copyWith(
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 4.0, right: 20.0),
                        child: Divider(
                          color: kGrey1,
                          thickness: 1.0,
                        ),
                      ),
                      for (UploadModel model in uploadedFiles)
                        buildUploadedModelCard(model),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DottedBorder(
                                dashPattern: [8, 5],
                                color: kGrey6,
                                strokeWidth: 1.0,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8.0),
                                child: TextButton(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 16.0),
                                          SvgImage(
                                            svgName: 'ic_attach',
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            'File đính kèm',
                                            style: kDefaultTextStyle.copyWith(
                                                color: kGrey7),
                                          ),
                                        ],
                                      )),
                                  onPressed: () {
                                    attachedAndUploadFile();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 12.0, right: 20.0),
                        child: Text(
                          'Accepted format: PNG, JPEG, or PDF. Up to 5MB',
                          style: kSmallGreyTextStyle.copyWith(
                              color: kGrey8, fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 36.0, horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'THÊM',
                                    style: kDefaultTextStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kBlue1),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: BorderSide(color: kBlue1)))),
                                onPressed: () async {
                                  if (requireNoTextController.text.isEmpty ||
                                      requireDateTextController.text.isEmpty ||
                                      requireLimestoneSheetTextController
                                          .text.isEmpty) {
                                    setState(() {
                                      requireNoValidation =
                                          requireNoTextController.text.isEmpty;
                                      requireDateValidation =
                                          requireDateTextController
                                              .text.isEmpty;
                                      requireLimestoneSheetValidation =
                                          requireLimestoneSheetTextController
                                              .text.isEmpty;
                                    });
                                    return;
                                  } else {
                                    final response = await Provider.of<
                                                ManagerReceivingLimestoneModel>(
                                            context,
                                            listen: false)
                                        .saveReceipt(
                                      sheetSelected.value,
                                      DateFormat(Constant.ddMMyyyyHHmm2)
                                          .parse(requireDateTextController.text)
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      requireNoTextController.text,
                                      uploadedFiles.isNullOrEmpty
                                          ? []
                                          : uploadedFiles
                                              .map((_) => _.fileName)
                                              .toList(),
                                      uploadedFiles.isNullOrEmpty
                                          ? []
                                          : uploadedFiles
                                              .map((_) => _.filePath)
                                              .toList(),
                                    );
                                    Navigator.of(context).pop(response);
                                    NotificationDialog.show(
                                        context,
                                        response.isSuccess()
                                            ? 'ic_success'
                                            : 'ic_error',
                                        response.isSuccess()
                                            ? 'Xác nhận thành công'
                                            : 'Đã xảy ra lỗi, Vui lòng thử lại');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> attachedAndUploadFile() async {
    UploadModel uploaded = await FileUtils.instance.uploadFileFromSdcard(
        context,
        fileType: FileType.custom,
        allowExtentions: ['jpg', 'pdf', 'png', 'jpeg']);
    if (uploaded != null &&
        uploaded.uploadStatus == UploadStatus.upload_success) {
      setState(() {
        uploadedFiles.add(uploaded);
      });
    }
  }

  Widget buildUploadedModelCard(UploadModel model) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                  ImageUtils.instance.getImageType(model.fileName),
                  height: 20,
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Text(model.fileName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: kDefaultTextStyle.copyWith(
                      fontWeight: FontWeight.w700, color: kColorPrimary)),
            ),
            SvgImage(
              svgName: "ic_delete",
              onTap: () {
                setState(() {
                  uploadedFiles.remove(model);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
