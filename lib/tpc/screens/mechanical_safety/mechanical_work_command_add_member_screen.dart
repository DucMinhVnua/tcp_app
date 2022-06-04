import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/common/constants/colors.dart';
import 'package:workflow_manager/common/constants/dimens.dart';
import 'package:workflow_manager/common/constants/styles.dart';
import 'package:workflow_manager/common/utils/svg_utils.dart';
import 'package:workflow_manager/models/account_model.dart';
import 'package:workflow_manager/models/mechanical_work_command_model.dart';
import 'package:workflow_manager/models/response/list_member_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_command_detail_response.dart';
import 'package:workflow_manager/models/response/mechanical_work_commands_response.dart';
import 'package:workflow_manager/tpc/screens/other/add_button.dart';
import 'package:workflow_manager/tpc/screens/other/custom_one_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/custom_two_button_dialog.dart';
import 'package:workflow_manager/tpc/screens/other/list_item_common.dart';
import 'package:workflow_manager/tpc/screens/other/notification_dialog.dart';

class MechanicalWorkCommandAddMemberScreen extends StatefulWidget {
  final MechanicalWorkCommand mechanicalWorkCommand;
  MechanicalWorkCommandAddMemberScreen({
    this.mechanicalWorkCommand,
  });

  @override
  _MechanicalWorkCommandAddMemberScreenState createState() => _MechanicalWorkCommandAddMemberScreenState();
}

class _MechanicalWorkCommandAddMemberScreenState extends State<MechanicalWorkCommandAddMemberScreen> {
  TextEditingController _textFieldNameController = TextEditingController();
  TextEditingController _textFieldLevelController = TextEditingController();
  Users _memberAdd;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRefresh();
    });
  }


  @override
  void dispose() {
    _textFieldNameController.dispose();
    _textFieldLevelController.dispose();
    super.dispose();
  }

  void onRefresh() {
    Provider.of<MechanicalWorkCommandModel>(context, listen: false)
        .getMechanicalWorkCommandDetail(widget.mechanicalWorkCommand.iD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bổ sung thành viên tham gia"),
      ),
      body: SafeArea(
        child: Consumer<MechanicalWorkCommandModel>(
          builder: (_, model, __) => (model.detailData == null ||
              model.detailData.thongTinChung.iD != widget.mechanicalWorkCommand.iD)
              ? Container()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * kDefaultAppBarBottom,
                alignment: Alignment.centerLeft,
                color: kGrey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: Text(
                        "Danh sách thành viên tham gia: ${model.detailData.danhSachNhanVien.length}",
                        style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    AddButton(
                      onTapButton: () async {
                          final responseMemberList = await Provider.of<AccountModel>(context, listen: false).getMemberList();
                          _displayDialogAddMemberJoin(context, responseMemberList.data.users);
                        },
                      ),
                    ],
                  )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListItemEditDelete(
                          itemPairsData: [
                            {
                              'icon': 'ic_avatar',
                              'content':
                              '${index + 1}. ${model.detailData.danhSachNhanVien[index].hoVaTen}',
                            },
                            {
                              'icon': 'ic_level_safety',
                              'content':
                              'Số thẻ an toàn : ${model.detailData.danhSachNhanVien[index].bacAnToanDien}',
                            }
                          ],
                          showAction: !(model.detailData.danhSachNhanVien[index].thoiGianDenLamViec > 0),
                          onEdit: () => {},
                          onDelete: () => _displayDialogDeleteMemberJoin(context, model.detailData.danhSachNhanVien[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 32,
                          color: kGrey1,
                          thickness: 1.0,
                        );
                      },
                      itemCount: model.detailData.danhSachNhanVien.length),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


  Widget _contentAddMemberJoinDialog(List<Users> members) {
    List<String> listNameMember = [];
    for (var i = 0; i < members.length; i++) {
      listNameMember.add(members[i].name);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownSearch<Users>(
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
            items: members,
            itemAsString: (Users member) => member.name,
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              // enabledBorder: UnderlineInputBorder(
              //   borderSide: BorderSide(color: kBlue1),
              // ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kBlue1),
              ),
              hintText: 'Chọn nhân sự tham gia',
              hintStyle: kDefaultTextStyle.copyWith(
                  color: kGrey2
              ),
            ),
            onChanged: (Users member) {
              _textFieldNameController.text = member.name;
              _memberAdd = member;
            } ,
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              enableSuggestions: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                contentPadding: EdgeInsets.all(8.0),
                hintText: 'Tìm kiếm nhân viên',
              ),
            ),
          ),
        ),
        SizedBox(width: double.infinity, height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Số thẻ an toàn',
            style: kSmallGreyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: _textFieldLevelController,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 13.0,
                color: kBlack1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _displayDialogAddMemberJoin(BuildContext context, List<Users> members) async {
    _textFieldNameController.clear();
    _textFieldLevelController.clear();
    _memberAdd = null;
    Widget contentDialog = _contentAddMemberJoinDialog(members);
    CustomTwoButtonDialog dialogAddMember = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Text(
          'Thêm mới nhân sự',
          textAlign: TextAlign.center,
          style: kMediumBlackTextStyle,
        ),
      ),
      content: contentDialog,
      txtNegativeBtn: 'HUỶ',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'THÊM',
      onTapPositiveBtn: () async {
        if (_textFieldNameController.text.isEmpty || _textFieldLevelController.text.isEmpty) {
          ToastMessage.show('Nhân sự tham gia và bậc an toàn điện không được để trống', ToastStyle.error);
          return;
        }
        final response = await Provider.of<MechanicalWorkCommandModel>(context, listen: false)
            .addMemberJoin(
            widget.mechanicalWorkCommand.iD,
            _memberAdd.iD,
            _textFieldLevelController.text
        );
        Navigator.of(context).pop(response);
        NotificationDialog.show(
            context,
            response.isSuccess() ? 'ic_success' : 'ic_error',
            response.isSuccess() ? 'Bổ sung thành công' : 'Đã xảy ra lỗi, Vui lòng thử lại');
      },
    );
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => dialogAddMember,
      barrierDismissible: false,
    );
    if (result != null) {
      onRefresh();
    }
  }

  void _displayDialogEditMemberJoin(BuildContext context, DanhSachNhanVien member) {
    CustomOneButtonDialog dialogEditMember = CustomOneButtonDialog(
      context: context,
      title: 'EDIT',
      content: Container(),
      txtBtn: 'ĐỒNG Ý',
      onTapBtn: () {
        Navigator.of(context).pop();
      },
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => dialogEditMember,
      barrierDismissible: false,
    );
  }

  void _displayDialogDeleteMemberJoin(BuildContext context, DanhSachNhanVien member) async {
    CustomTwoButtonDialog dialogDeleteMember = CustomTwoButtonDialog(
      context: context,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SvgImage(
          svgName: 'ic_error',
        ),
      ),
      showTitleDivider: false,
      content: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Bạn có thật sự muốn xóa thành viên này?',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      txtNegativeBtn: 'HUỶ',
      onTapNegativeBtn: () {
        Navigator.of(context).pop();
      },
      txtPositiveBtn: 'ĐỒNG Ý',
      onTapPositiveBtn: () async {
        final response = await Provider.of<MechanicalWorkCommandModel>(context, listen: false)
            .deleteMemberJoin(
            widget.mechanicalWorkCommand.iD,
            member.iDNhanVien
        );

        // ToastMessage.show(response.data.text,
        //     response.isSuccess() ? ToastStyle.success : ToastStyle.error);
        Navigator.of(context).pop(response);
        NotificationDialog.show(
            context,
            response.isSuccess() ? 'ic_success' : 'ic_error',
            response.isSuccess() ? 'Xóa thành công' : 'Đã xảy ra lỗi, Vui lòng thử lại');
      },
    );
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => dialogDeleteMember,
      barrierDismissible: false,
    );
    if (result != null) {
      onRefresh();
    }
  }

}