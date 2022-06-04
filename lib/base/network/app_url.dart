
class AppUrl {
  static const String baseURL = "http://27.72.28.202:83/api/";
  static const String login = "Account/login";
  static const String get_list_member = "Account/GetList";
  static const String get_list_department = "Dept/Index";

  //MODULE 1
  static const String work_commands = "LenhCongTac/index";
  static const String work_command_detail = "LenhCongTac/Detail";
  static const String work_command_add_member_join = "LenhCongTac/BoSungMotThanhVienThamGia";
  static const String work_command_delete_member_join = "LenhCongTac/XoaMotThanhVienThamGia";
  static const String work_command_add_work_sequence = "LenhCongTac/BoSungMotTrinhTuCongViec";
  static const String work_command_delete_work_sequence = "LenhCongTac/XoaMotTrinhTuCongViec";
  static const String work_command_notify_complete = "LenhCongTac/ThongBaoHoanThanh";
  static const String work_command_change_direct_commander = "LenhCongTac/ThayDoiChiHuyTrucTiep";
  static const String work_command_list_direct_commander = "LenhCongTac/DanhSachChiHuyTrucTiep";
  static const String work_command_is_check_in = "LenhCongTac/IsCheckIn";
  static const String work_command_check_in = "LenhCongTac/CheckIn";
  static const String work_command_is_check_out = "LenhCongTac/IsCheckOut";
  static const String work_command_check_out = "LenhCongTac/CheckOut";
  static const String work_command_confirm_attendance = "LenhCongTac/XacNhanCoMatDayDu";
  static const String work_command_confirm_withdraw = "LenhCongTac/XacNhanRutKhoi";
  static const String work_command_is_confirm_sequence = "LenhCongTac/IsTrinhTuThucHien";
  static const String work_command_confirm_sequence = "LenhCongTac/TrinhTuThucHien";
  static const String work_command_sign_process = "LenhCongTac/ViewFileTrinhKy";
  static const String work_command_change_shift_leader = "LenhCongTac/ThayDoiTruongCa";
  static const String work_command_change_assignment = "LenhCongTac/ThayDoiPhanCong";
  static const String work_command_confirm_change_shift_leader = "LenhCongTac/XacNhanThayDoi";
  static const String work_command_cancel = "LenhCongTac/IsCancel";

  //MODULE 2
  static const String work_sheets = "PhieuCongTac/index";
  static const String work_sheet_detail = "PhieuCongTac/Detail";
  static const String work_sheet_add_member_join = "PhieuCongTac/BoSungMotThanhVienThamGia";
  static const String work_sheet_delete_member_join = "PhieuCongTac/XoaMotThanhVienThamGia";
  static const String work_sheet_change_direct_commander = "PhieuCongTac/ThayDoiChiHuyTrucTiep";
  static const String work_sheet_list_direct_commander = "PhieuCongTac/DanhSachChiHuyTrucTiep";
  static const String work_sheet_notify_complete = "PhieuCongTac/ThongBaoHoanThanh";
  static const String work_sheet_add_work_place = "PhieuCongTac/BoSungMotDiaDiemCongViec";
  static const String work_sheet_delete_work_place = "PhieuCongTac/XoaMotDiaDiemCongViec";
  static const String work_sheet_is_check_in = "PhieuCongTac/IsCheckIn";
  static const String work_sheet_check_in = "PhieuCongTac/CheckIn";
  static const String work_sheet_is_check_out = "PhieuCongTac/IsCheckOut";
  static const String work_sheet_check_out = "PhieuCongTac/CheckOut";
  static const String work_sheet_confirm_attendance = "PhieuCongTac/XacNhanCoMatDayDu";
  static const String work_sheet_confirm_withdraw = "PhieuCongTac/XacNhanRutKhoi";
  static const String work_sheet_is_confirm_location = "PhieuCongTac/IsXacNhanDiaDiem";
  static const String work_sheet_confirm_location = "PhieuCongTac/XacNhanDiaDiem";
  static const String work_sheet_sign_process = "PhieuCongTac/ViewFileTrinhKy";
  static const String work_sheet_change_shift_leader = "PhieuCongTac/ThayDoiTruongCa";
  static const String work_sheet_change_assignment = "PhieuCongTac/ThayDoiPhanCong";
  static const String work_sheet_confirm_change_shift_leader = "PhieuCongTac/XacNhanThayDoi";
  static const String work_sheet_cancel = "PhieuCongTac/IsCancel";

  //MODULE 3
  static const String mechanical_work_commands = "LenhCongTacCNH/index";
  static const String mechanical_work_command_detail = "LenhCongTacCNH/Detail";
  static const String mechanical_work_command_change_direct_commander = "LenhCongTacCNH/ThayDoiChiHuyTrucTiep";
  static const String mechanical_work_command_list_direct_commander = "LenhCongTacCNH/DanhSachChiHuyTrucTiep";
  static const String mechanical_work_command_add_member_join = "LenhCongTacCNH/BoSungMotThanhVienThamGia";
  static const String mechanical_work_command_delete_member_join = "LenhCongTacCNH/XoaMotThanhVienThamGia";
  static const String mechanical_work_command_add_work_diary = "LenhCongTacCNH/BoSungMotNhatKyCongViec";
  static const String mechanical_work_command_delete_work_diary = "LenhCongTacCNH/XoaMotNhatKyCongViec";
  static const String mechanical_work_command_notify_complete = "LenhCongTacCNH/ThongBaoHoanThanh";
  static const String mechanical_work_command_is_check_in = "LenhCongTacCNH/IsCheckIn";
  static const String mechanical_work_command_check_in = "LenhCongTacCNH/CheckIn";
  static const String mechanical_work_command_is_check_out = "LenhCongTacCNH/IsCheckOut";
  static const String mechanical_work_command_check_out = "LenhCongTacCNH/CheckOut";
  static const String mechanical_work_command_confirm_attendance = "LenhCongTacCNH/XacNhanCoMatDayDu";
  static const String mechanical_work_command_confirm_withdraw = "LenhCongTacCNH/XacNhanRutKhoi";
  static const String mechanical_work_command_is_confirm_diary = "LenhCongTacCNH/IsNhatKy";
  static const String mechanical_work_command_confirm_diary = "LenhCongTacCNH/NhatKy";
  static const String mechanical_work_command_sign_process = "LenhCongTacCNH/ViewFileTrinhKy";
  static const String mechanical_work_command_change_shift_leader = "LenhCongTacCNH/ThayDoiTruongCa";
  static const String mechanical_work_command_change_assignment = "LenhCongTacCNH/ThayDoiPhanCong";
  static const String mechanical_work_command_confirm_change_shift_leader = "LenhCongTacCNH/XacNhanThayDoi";
  static const String mechanical_work_command_cancel = "LenhCongTacCNH/IsCancel";

  //MODULE 4
  static const String mechanical_work_sheets = "PhieuCongTacCNH/index";
  static const String mechanical_work_sheet_detail = "PhieuCongTacCNH/Detail";
  static const String mechanical_work_sheet_add_member_join = "PhieuCongTacCNH/BoSungMotThanhVienThamGia";
  static const String mechanical_work_sheet_delete_member_join = "PhieuCongTacCNH/XoaMotThanhVienThamGia";
  static const String mechanical_work_sheet_change_direct_commander = "PhieuCongTacCNH/ThayDoiNguoiChiHuyTrucTiep";
  static const String mechanical_work_sheet_list_direct_commander = "PhieuCongTacCNH/DanhSachChiHuyTrucTiep";
  static const String mechanical_work_sheet_notify_complete = "PhieuCongTacCNH/ThongBaoHoanThanh";
  static const String mechanical_work_sheet_add_work_place = "PhieuCongTacCNH/BoSungMotDiaDiemCongViec";
  static const String mechanical_work_sheet_delete_work_place = "PhieuCongTacCNH/XoaMotDiaDiemCongViec";
  static const String mechanical_work_sheet_is_check_in = "PhieuCongTacCNH/IsCheckIn";
  static const String mechanical_work_sheet_check_in = "PhieuCongTacCNH/CheckIn";
  static const String mechanical_work_sheet_is_check_out = "PhieuCongTacCNH/IsCheckOut";
  static const String mechanical_work_sheet_check_out = "PhieuCongTacCNH/CheckOut";
  static const String mechanical_work_sheet_confirm_attendance = "PhieuCongTacCNH/XacNhanCoMatDayDu";
  static const String mechanical_work_sheet_confirm_withdraw = "PhieuCongTacCNH/XacNhanRutKhoi";
  static const String mechanical_work_sheet_is_confirm_location = "PhieuCongTacCNH/IsXacNhanDiaDiem";
  static const String mechanical_work_sheet_confirm_location = "PhieuCongTacCNH/XacNhanDiaDiem";
  static const String mechanical_work_sheet_sign_process = "PhieuCongTacCNH/ViewFileTrinhKy";
  static const String mechanical_work_sheet_change_shift_leader = "PhieuCongTacCNH/ThayDoiTruongCa";
  static const String mechanical_work_sheet_change_assignment = "PhieuCongTacCNH/ThayDoiPhanCong";
  static const String mechanical_work_sheet_confirm_change_shift_leader = "PhieuCongTacCNH/XacNhanThayDoi";
  static const String mechanical_work_sheet_cancel = "PhieuCongTacCNH/IsCancel";

  //MODULE 5
  static const String manipulation_sheets = "PhieuThaoTac/index";
  static const String manipulation_sheet_detail = "PhieuThaoTac/Detail";
  static const String manipulation_sheet_update_unusual_event = "PhieuThaoTac/CapNhatSuKienBatThuong";
  static const String manipulation_sheet_is_order_receiving = "PhieuThaoTac/IsTrinhTuNhanLenh";
  static const String manipulation_sheet_order_receiving = "PhieuThaoTac/XacNhanTrinhTuNhanLenh";
  static const String manipulation_sheet_order_command = "PhieuThaoTac/XacNhanTrinhTuRaLenh";
  static const String manipulation_sheet_add_sequence = "PhieuThaoTac/BoSungMotTrinhTuThaoTac";
  static const String manipulation_sheet_edit_sequence  = "PhieuThaoTac/CapNhatMotTrinhTuThaoTac";
  static const String manipulation_sheet_delete_sequence  = "PhieuThaoTac/XoaMotTrinhTuThaoTac";
  static const String manipulation_sheet_notify_complete = "PhieuThaoTac/ThongBaoHoanThanh";

  //MODULE 6
  static const String manager_receiving_oil = "TiepNhanHoSoDau/index";
  static const String manager_receiving_oil_detail = "TiepNhanHoSoDau/ChiTietTiepNhan";
  static const String manager_receiving_oil_create_receipt = "TiepNhanHoSoDau/TaoTiepNhan";
  static const String manager_receiving_oil_require_before = "TiepNhanHoSoDau/YeuCauTiepNhanTruocVaTrong";
  static const String manager_receiving_oil_require_after = "TiepNhanHoSoDau/YeuCauTiepNhanSau";
  static const String manager_receiving_oil_notice_complete = "TiepNhanHoSoDau/CapNhatTrangThaiHoanThanh";

  //MODULE 7
  static const String manager_receiving_limestone = "TiepNhanHoSoDaVoi/index";
  static const String manager_receiving_limestone_detail = "TiepNhanHoSoDaVoi/ChiTietTiepNhan";
  static const String manager_receiving_limestone_create_receipt = "TiepNhanHoSoDaVoi/TaoTiepNhan";
  static const String manager_receiving_limestone_save_receipt = "TiepNhanHoSoDaVoi/LuuTiepNhan";
  static const String manager_receiving_limestone_create_require = "TiepNhanHoSoDaVoi/TaoYeuCauTiepNhan";
  static const String manager_receiving_limestone_require_before = "TiepNhanHoSoDaVoi/YeuCauTiepNhanTruocVaTrong";
  static const String manager_receiving_limestone_notice_complete = "TiepNhanHoSoDaVoi/ThongBaoHoanThanh";



  //MODULE 8
  // static const String reception_with_contract = "LenhCongTacCNH/index";

  //MODULE 9
  // static const String reception_without_contract = "LenhCongTacCNH/index";


  // TEST
  // static const String baseURL = "http://test-api.lione.vn/api/";
  // static const String oneSignalAppID = '174cef11-9b50-4e38-9304-940f6b909233';

  // DEV
  // static const String baseURL = "http://dev-api.lione.vn/api/";
  // static const String oneSignalAppID = '174cef11-9b50-4e38-9304-940f6b909233';

  // DEV SME
  // static const String baseURL = "http://dev-api.sme.lione.vn/api/";
  // static const String oneSignalAppID = '174cef11-9b50-4e38-9304-940f6b909233';

  // UAT:
  // static String baseURL = "https://api-gateway.lione.vn/api/";
  // static const String oneSignalAppID ='dc6a8a20-0674-4d87-b681-cf67d5308fa4';

  // RELEASE:
  // static const String baseURL = "https://api-gateway.lione.vn/api/";
  // static const String oneSignalAppID = 'fb5be698-9b79-4027-85ed-3a271fc88252';

  // ------------------------------ manager ----------------------------------//
  static const String url_google_doc =
      "https://docs.google.com/gview?embedded=true&url=";
  static const String homeIndex = "home/index";
  static const String homeChangeViewFile = "home/ChangeViewFile";
  static const String changePassword = "Account/ChangePassword";
  static const String updateProfile = "Account/UpdateProfile";
  static const String profileDetail = "account/ProfileDetail";
  static const String sendInfoDevice = "device/reg";
  static const String removeInfoDevice = "device/remove";
  static const String getInfoNotifyById = "Notification/NtfsById";
  static const String getConfigApp = "home/infoversion";

  // ------------------ Quy trình thủ tục - procedures -----------------------//
  static const String listRegister = "register/index";
  static const String reportProcedure = "report/wf";
  static const String listResolve = "record/index";
  static const String listReportState = "report/ResolveStatusIndex";
  static const String exportResolveStatusExcel =
      "report/ExportResolveStatusExcel";
  static const String registerRemove = "register/remove";

  static const String registerRating = "register/Rating";
  static const String registerInfo = "register/Info";
  static const String recordInfo = "record/Info";
  static const String recordRating = "record/Rating";

  // action giải quyết
  static const String recordIsResolve = "record/IsResolve";
  static const String recordIsDoneInfo = "record/IsDoneInfo";
  static const String recordDoneInfo = "record/DoneInfo";

  static const String registerIsResentInfo = "register/IsResentInfo";
  static const String registerResentInfo = "register/ResentInfo";

  static const String recordIsRequireAddition = "record/IsRequireAddition";
  static const String recordRequireAddition = "record/RequireAddition";

  // require addition trong đăng ký và giải quyết
  static const String registerIsDoneRequireAddition =
      "register/IsDoneRequireAddition";
  static const String registerDoneRequireAddition =
      "register/DoneRequireAddition";
  static const String recordIsDoneRequireAddition =
      "record/IsDoneRequireAddition";
  static const String recordDoneRequireAddition = "record/DoneRequireAddition";

  static const String recordSaveInfoFs = "record/SaveInfoFs";
  static const String recordRemoveInfoFs = "record/RemoveInfoFs";

  static const String recordSaveInfoStepFs = "record/SaveInfoStepFs";
  static const String recordRemoveInfoStepFs = "record/RemoveInfoStepFs";

  static const String recordIsResolveList = "record/IsResolveList";
  static const String recordResolveList = "record/ResolveList";

  static const String ratingIsRateServiceRecord = "rating/IsRateServiceRecord";
  static const String ratingSaveRateServiceRecord =
      "rating/SaveRateServiceRecord";

  static const String registerInfoStepHistory = "register/InfoStepHistory";

  static const String listHistory = "Task/GetListJobHistory";
  static const String listComment = "Task/GetDiscuss";
  static const String addComment = "Task/AddDiscuss";
  static const String likeComment = "Task/Like";
  static const String deleteComment = "Task/DeleteDiscuss";
  static const String listProcessContent = "Task/GetProcessedContent";
  static const String addProcessContent = "Task/AddProcessedContent";
  static const String editProcessContent = "Task/EditProcessedContent";
  static const String deleteProcessContent = "Task/DeleteProcessedContent";

  static const String getQTTTRegisterTypes = "register/types";
  static const String getQTTTRegisterServices = "register/services";
  static const String getQTTTRegisterCreate = "register/create";
  static const String getQTTTRegisterUpdate = "register/update";
  static const String getQTTTRegisterChange = "register/change";
  static const String getQTTTRegisterSave = "register/save";
  static const String getQTTTRegisterChangeFeatured = "register/ChangeFeatured";
  static const String getQTTTRegisterUserInfo = "register/userInfo";
  static const String getQTTTRecordSaveData = "record/SaveData";
  static const String getQTTTRecordSignatures = "record/signatures";
  static const String getQTTTSignatureCheckPasswordSignature =
      "Signature/CheckPasswordSignature";
  static const String getQTTTSignatureSavePDF = "Signature/savePDF";
  static const String getQTTTRatingServiceRateView = "rating/ServiceRateView";

  // -------------------- Quản lý công việc - tpc -----------------------//
  static const String createNewTrip = "/goTogether/trip/create";

  static const String getListTrip = "/goTogether/trip/list";

  // group task
  static const String getListGroupTask = "GroupTask/Index";
  static const String getColumnGroup = "GroupTask/GetColumn";
  static const String getListColumnGroup = "GroupTask/DataForDetail";
  static const String getTaskStatus = "GroupTask/GetListStatus";
  static const String getDataForNewGroup = "GroupTask/GetDataForCreateGroupJob";
  static const String deleteGroupTask = "GroupTask/DeleteJobGroups";
  static const String changeStatusForList = "GroupTask/ChangeStatusForList";
  static const String createNewGroup = "GroupTask/CreateGroupJob";
  static const String editGroup = "GroupTask/EditJobGroupAPI";
  static const String groupGetListDiscuss = "GroupTask/GetListDiscussAPI";
  static const String groupDeleteDiscuss = "GroupTask/DeleteDiscussAPI";
  static const String groupAddDiscuss = "GroupTask/AddDiscussAPI";
  static const String groupLikeOrDislike = "GroupTask/Like";
  static const String groupGetListHistory = "GroupTask/GetListHistoryAPI";
  static const String getDataForIndex = "ReportQLCV/GetDataForIndex";
  static const String getDataFilterColumnGroup =
      "GroupTask/GetDataForSearchDetail";
  static const String getListUserColumnGroup = "GroupTask/GetListUserForSearch";

  // List task
  static const String getListTask = "Task/Index";
  static const String getTaskInfo = "Task/DetailJob";

  static const String getJobDetails = "Task/GetListJobDetail";
  static const String getCompleteJobDetails = "Task/CompleteJobDetail";
  static const String getUncompleteJobDetails = "Task/UnCompleteJobDetail";
  static const String getDeleteJobDetail = "Task/DeleteJobDetail";
  static const String getAddJobDetail = "Task/AddJobDetail";
  static const String getChangePercent = "Task/ChangePercent";
  static const String getDeleteJob = "Task/DeleteJob";

  static const String getSubJob = "Task/GetListChildrenJob";
  static const String getAddFile = "Task/AddFile";
  static const String getDeleteFile = "Task/DeleteFile";
  static const String getGetListFile = "Task/GetListFile";

  static const String getAddExtension = "Task/AddExtension";
  static const String getApproveExtension = "Task/ApproveExtension";
  static const String getRejectExtension = "Task/RejectExtension";
  static const String getGetHistoryExtension = "Task/GetHistoryExtension";

  //group job details
  static const String getGroupTaskAddFile = "GroupTask/AddFile";
  static const String getGroupTaskGetListFile = "GroupTask/GetListFile";
  static const String getGroupTaskDeleteFile = "GroupTask/DeleteFile";
  static const String getGroupTaskGetDataForEdit = "GroupTask/GetDataForEdit";
  static const String getGroupTaskGetListStatusChange =
      "GroupTask/GetListStatusChange";
  static const String getGroupTaskChangeStatus = "GroupTask/ChangeStatus";

  static const String getGroupTaskGetListUserGroupJob =
      "GroupTask/GetListUserGroupJob";
  static const String getGroupTaskGetListDeptAPI = "GroupTask/GetListDeptAPI";
  static const String getGroupTaskGetListUserByDeptAPI =
      "GroupTask/GetListUserByDeptAPI";
  static const String getGroupTaskGetInfoUserAPI = "GroupTask/GetInfoUserAPI";
  static const String getGroupTaskAddMember = "GroupTask/AddMember";
  static const String getGroupTaskEditMemberAPI = "GroupTask/EditMemberAPI";
  static const String getGroupTaskDeleteMember = "GroupTask/DeleteMember";

  static const String getGroupTaskAddColumn = "GroupTask/AddColumn";
  static const String getGroupTaskDeleteColumn = "GroupTask/DeleteColumn";
  static const String getGroupTaskChangeTitle = "GroupTask/ChangeTitle";
  static const String changeJobCoExcuterAndSupervisors =
      "Task/ChangeJobCoExcuterAndSupervisors";

  // User
  static const String getListUser = "Task/GetUserForSearch";
  static const String getGuestPlaceContractDetail = "guestplace/contractdetail";

  // List status
  static const String getListStatus = "Task/GetListStatusForCreated";
  static const String changeJobStatus = "Task/ChangeJobStatus";
  static const String getChangeUndefinedStatus = "Task/ChangeUndefinedStatus";

  // Filter list task
  static const String listForSearch = "Task/GetListForSearch";
  static const String getJobGroupForSearch = "Task/GetJobGroupForSearch";

  // Rating
  static const String ratingCloseJob = "Task/RatingCloseJob";

  //transfer
  static const String getDataForTranferUser = "Task/GetDataForTranferUser";
  static const String getTransferAndRateUser = "Task/TranferAndRateUser";
  static const String getTranferUser = "Task/TranferUser";
  static const String getListExecutorAPI = "Task/GetListExecutorAPI";

  //create
  static const String getCreateJob = "Task/CreateJob";
  static const String getDataForCreateJob = "Task/GetDataForCreateJob";
  static const String getCreateJobGroupForSearch = "Task/GetJobGroupForSearch";
  static const String getListGroupJobCol = "Task/GetListGroupJobCol";
  static const String getUserForCreateJob = "Task/GetUserForCreateJob";
  static const String getDataForEdit = "Task/GetDataForEdit";

  //edit
  static const String getSaveDetailJob = "Task/SaveDetailJob";

  // report
  static const String getDataForListGroupJob =
      "ReportQLCV/GetDataForListGroupJob";
  static const String getDataForListGroupJobReport =
      "ReportQLCV/GetDataGroupJobReport";
  static const String getDataForListGroupJobPesonal =
      "ReportQLCV/GetDataForListGroupJobPesonal";
  static const String getDataGroupJobReportPersonal =
      "ReportQLCV/GetDataGroupJobReportPersonal";
  static const String getDataGroupJobManagerReport =
      "ReportQLCV/GetDataGroupJobManagerReport";
  static const String getDataForListGroupJobManager =
      "ReportQLCV/GetDataForListGroupJobManager";

  // static const String getDataPerformanceReport =
  //     "ReportQLCV/GetDataPerformanceReport";
  static const String getListUserPerformanceReport =
      "ReportQLCV/GetListUserPerformanceReport";
  static const String getListJobGroup = "ReportQLCV/GetListJobGroup";
  static const String getDataDetailGroupJobReport =
      "ReportQLCV/GetDataDetailGroupJobReport";

  //notification
  static const String getNotification = "Notification/Index";
  static const String markNotificationRead = "Notification/StatusChange";

  // -------------------- Mượn trả tài liệu - borrowPayDocument -----------------------//
  static const String getBorrowSearch = "Borrow/Search";
  static const String getBorrowAuser = "Borrow/Auser";
  static const String getBorrowCreated = "Borrow/Created";
  static const String getBorrowIndex = "Borrow/Index";
  static const String getStatistic = "report/stgdocborrow";
  static const String getBorrowRemoves = "Borrow/Removes"; // xóa nhiều tài liệu
  static const String getBorrowApproved =
      "Borrow/Approved"; // xác nhận duyệt - tài liệu đã đăng ký mượn(quyền của lãnh đạo)
  static const String getBorrowRejected =
      "Borrow/Rejected"; // xác nhận từ chối - tài liệu đã đăng ký mượn(quyền của lãnh đạo)
  static const String getBorrowDisabled =
      "Borrow/Disabled"; //  xác nhận thu hồi - tài liệu đã được duyệt(quyền của lãnh đạo)
  static const String getBorrowClosed =
      "Borrow/Closed"; //  xác nhận đóng hồ sơ- tài liệu đã trả(quyền của văn thư)
  static const String getBorrowBorrowed =
      "Borrow/Borrowed"; //  xác nhận CHO MƯỢN - TÀI LIỆU ĐÃ DUYỆT(quyền của văn thư)
  static const String getBorrowRemove =
      "Borrow/Remove"; //  xóa 1 tài liệu trong bottonsheet
  static const String getBorrowDetail = "Borrow/Detail";

  // -------------------- Quản lý serial -----------------------//
  static const String qlmsSerialRemove = "qlms/SerialRemove";
  static const String qlmsSerialUpdate = "qlms/SerialUpdate";
  static const String qlmsSerialCreate = "qlms/SerialCreate";
  static const String qlmsSerialChange = "qlms/SerialChange";
  static const String qlmsSerialSave = "qlms/SerialSave";
  static const String qlmsGetContractsByRequisition =
      "qlms/GetContractsByRequisition";

  // -------------------- Quản lý thanh toán -----------------------//

  static const String qlmsPaymentProgressIndex = "qlms/PaymentProgressIndex";
  static const String qlmsDeliveryProgressSendMail =
      "qlms/DeliveryProgressSendMail";
  static const String qlmsPaymentProgressDetail = "qlms/PaymentProgressDetail";
  static const String qlmsPaymentProgressUpdate = "qlms/PaymentProgressUpdate";
  static const String qlmsContractOutOfStock = "qlms/ContractOutOfStock";
  static const String qlmsDeliveryProgress = "qlms/DeliveryProgress";
  static const String qlmsDeliveryProgressHistory =
      "qlms/DeliveryProgressHistory";
  static const String qlmsSendCheck = "qlms/SendCheck";
  static const String qlmsUpdateDeliveryProgress =
      "qlms/UpdateDeliveryProgress";
  static const String qlmsCreateDeliveryProgress =
      "qlms/CreateDeliveryProgress";
  static const String qlmsPaymentProgressComplete =
      "qlms/PaymentProgressComplete";
  static const String qlmsPaymentProgressSave = "qlms/PaymentProgressSave";
  static const String qlmsDeliveryIndex = "qlms/DeliveryIndex";
  static const String qlmsDeliveryView = "qlms/DeliveryView";
  static const String qlmsDeliveryUpdate = "qlms/DeliveryUpdate";
  static const String qlmsDeliverySave = "qlms/DeliverySave";
  static const String qlmsDeliveryFinish = "qlms/DeliveryFinish";
  static const String qlmsSaveDeliveryProgress = "qlms/SaveDeliveryProgress";
  static const String qlmsDeliveryProgressViewSendMail =
      "qlms/DeliveryProgressViewSendMail";
  static const String qlmsChangeDeliveryProgress =
      "qlms/ChangeDeliveryProgress";
  static const String qlmsViewCheckSlip = "qlms/ViewCheckSlip";

  // -------------------- Quản lý mua sắm -----------------------//
  static const String qlmsDashboard = "qlms/Dashboard";
  static const String qlmsContractSave = "qlms/ContractSave";
  static const String qlmsContractSigninInfo = "qlms/ContractSigninInfo";
  static const String qlmsSerialDetail = "qlms/SerialDetail";
  static const String qlmsSerialIndex = "qlms/SerialIndex";
  static const String qlmsReportShoppingList =
      "qlms/DashboardInternalByCategory";
  static const String qlmsDashboardProjectByCategory =
      "qlms/DashboardProjectByCategory";
  static const String qlmsChooseProviderIndex = "qlms/ChooseProviderIndex";
  static const String qlmsChooseProviderSendMail =
      "qlms/ChooseProviderSendMail";
  static const String qlmsChooseProviderCreateContentMail =
      "qlms/ChooseProviderCreateContentMail";
  static const String qlmsSuggestProviderSeletected =
      "qlms/SuggestProviderSeletected";
  static const String qlmsConfirmProviderDetail = "qlms/ConfirmProviderDetail";
  static const String qlmsChooseProviderDetail = "qlms/ChooseProviderDetail";
  static const String qlmsTyGia = "qlms/TyGia";
  static const String qlmsConfirmProviderApproval =
      "qlms/ConfirmProviderApproval";
  static const String qlmsConfirmProviderReject = "qlms/ConfirmProviderReject";
  static const String qlmsChooseProviderSave = "qlms/ChooseProviderSave";
  static const String qlmsConfirmProviderIndex = "qlms/ConfirmProviderIndex";
  static const String qlmsConfirmProviderMutilApproval =
      "qlms/ConfirmProviderMutilApproval";
  static const String qlmsPriceReferProvider = "qlms/PriceReferProvider";
  static const String qlmsProviderIndex = "qlms/ProviderIndex";
  static const String qlmsSavePriceReferProvider =
      "qlms/SavePriceReferProvider";
  static const String qlmsGetIModule = "qlms/GetIModule";
  static const String qlmsContractIndex = "qlms/ContractIndex";
  static const String qlmsContractDetail = "qlms/ContractDetail";

  // -------------------- Quản lý thanh toán -----------------------//
  static const String qlmsPaymentProgressChangeProject =
      "qlms/PaymentProgressChangeProject";
  static const String qlmsPaymentProgressChangePRCode =
      "qlms/PaymentProgressChangePRCode";
  static const String qlmsGetRequisitionsByProjectContract =
      "qlms/GetRequisitionsByProjectContract";
  static const String qlmsGetContractsByReqDelivery =
      "qlms/GetContractsByReqDelivery";

  // -------------------- Quản lý nhà danh mục hàng hoá -----------------------//
  static const String qlmsCommodityCategoryIndex =
      "qlms/CommodityCategoryIndex";
  static const String qlmsCommodityCategorySave = "qlms/CommodityCategorySave";
  static const String qlmsCommodityCategoryDelete =
      "qlms/CommodityCategoryDelete";
  static const String qlmsCommodityCategoryUpdate =
      "qlms/CommodityCategoryUpdate";
  static const String qlmsCommodityCategoryChange =
      "qlms/CommodityCategoryChange";

  // -------------------- Quản lý hàng hoá -----------------------//
  static const String qlmsCommodityIndex = "qlms/CommodityIndex";
  static const String qlmsCommodityDetail = "qlms/CommodityDetail";
  static const String qlmsCommodityCreate = "qlms/CommodityCreate";
  static const String qlmsCommoditySave = "qlms/CommoditySave";
  static const String qlmsCommodityUpdate = "qlms/CommodityUpdate";
  static const String qlmsCommodityChange = "qlms/CommodityChange";
  static const String qlmsCommodityDelete = "qlms/CommodityDelete";
  static const String qlmsGetCommodityByCategory =
      "qlms/GetCommodityByCategory";

  // -------------------- Quản lý nhà cung cấp -----------------------//
  // static const String qlmsProviderIndex = "qlms/ProviderIndex";
  static const String qlmsProviderDetail = "qlms/ProviderDetail";
  static const String qlmsProviderDetailDebtLog = "qlms/ProviderDetailDebtLog";
  static const String qlmsProviderCreate = "qlms/ProviderCreate";
  static const String qlmsProviderSave = "qlms/ProviderSave";
  static const String qlmsProviderUpdate = "qlms/ProviderUpdate";
  static const String qlmsProviderChange = "qlms/ProviderChange";
  static const String qlmsProviderViewDebtLog = "qlms/ProviderViewDebtLog";
  static const String qlmsProviderRemove = "qlms/ProviderRemove";
  static const String qlmsProviderDetailDebt = "qlms/ProviderDetailDebt";
  static const String qlmsProviderUpdateDebtLog = "qlms/ProviderUpdateDebtLog";
  static const String qlmsProviderChangeDebtLog = "qlms/ProviderChangeDebtLog";
  static const String qlmsSuggestProvider = "qlms/SuggestProvider";

  // quản lý hãng
  static const String qlmsManufacturIndex = "qlms/ManufacturIndex";
  static const String qlmsManufacturRemove = "qlms/ManufacturRemove";
  static const String qlmsManufacturCreate =
      "qlms/ManufacturCreate"; // render tạo mới
  static const String qlmsManufacturSave = "qlms/ManufacturSave"; // lưu tạo mới
  static const String qlmsManufacturUpdate =
      "qlms/ManufacturUpdate"; // render update
  static const String qlmsManufacturChange =
      "qlms/ManufacturChange"; // lưu update

  // đánh giá nhà cung cấp
  static const String qlmsProviderVoteIndex = "qlms/ProviderVoteIndex";
  static const String qlmsProviderVoteDetail = "qlms/ProviderVoteDetail";
  static const String qlmsProviderVoteCreate = "qlms/ProviderVoteCreate";
  static const String qlmsProviderVoteSave = "qlms/ProviderVoteSave";
  static const String qlmsProviderVoteUpdate = "qlms/ProviderVoteUpdate";
  static const String qlmsProviderVoteChange = "qlms/ProviderVoteChange";
  static const String qlmsProviderVoteRemove = "qlms/ProviderVoteRemove";
  static const String qlmsGetProvidersByProject = "qlms/GetProvidersByProject";
  static const String qlmsGetNameByProvider = "qlms/GetNameByProvider";

  // kế hoạch mua sắm:
  static const String qlmsPlanningIndex = "qlms/PlanningIndex";
  static const String qlmsPlanningDetail = "qlms/PlanningDetail";

  // yêu cầu mua sắm
  static const String qlmsRequisitionIndex = "qlms/RequisitionIndex";
  static const String qlmsRequisitionDetail = "qlms/RequisitionDetail";
  static const String qlmsRequisitionReject = "qlms/RequisitionReject";
  static const String qlmsRequisitionApprove = "qlms/RequisitionApprove";

  // báo cáo thống kê
  static const String qlmsGeneralReport = "qlms/GeneralReport";
  static const String qlmsDetailReport = "qlms/DetailReport";
  static const String qlmsProgressReport = "qlms/ProgressReport";
  static const String qlmsGetRequisitionsByProjectRp =
      "qlms/GetRequisitionsByProjectRp";

  // static const String qlmsGetContractsByRequisition = "qlms/GetContractsByRequisition";
  static const String qlmsImportReport = "qlms/importReport";
  static const String qlmsManufacturReport = "qlms/ManufacturReport";

  // -------------------- Quản lý kinh doanh - businessManagement -----------------------//
  static const String getProjecTreportIndex =
      "projectreport/index"; // tổng quan
  static const String getdataDetailPartMent =
      "projectreport/depts"; // Thống kê chi tiết - theo phòng ban
  static const String getDataDetailSeller =
      "projectreport/sellers"; // Thống kê chi tiết - theo seller
  static const String getDataDetailRegion =
      "ProjectReport/Areas"; // Thống kê chi tiết - theo tỉnh thành(vùng)
  static const String getDataDetailCustomers =
      "ProjectReport/customers"; // Thống kê chi tiết - theo khách hàng
  static const String getByTheTimeReport =
      "projectreport/Timereport"; // Doanh thu - theo thời gian
  static const String getDataByStateBusinessManager =
      "projectreport/PhaseReport"; // Doanh thu - theo thời gian
  static const String getTopContract =
      "projectreport/TopContract"; // top hợp đồng
  static const String getContractListAll =
      "contract/getall"; // danh sách hợp đồng
  static const String getTopSeller =
      "projectreport/TopSeller"; // danh sách top seller
  static const String getBonusDept =
      "projectreport/bonusPB"; // thưởng - theo phòng ban
  static const String getBonusBranch =
      "projectreport/bonusCN"; // thưởng - theo chi nhánh
  static const String getBonusSeller =
      "projectreport/bonusSeller"; // thưởng - top thưởng cá nhân
  static const String getExpectedYear =
      "projectreport/ExpectedYear"; // Doanh thu dự kiến  - các năm gần đây
  static const String getExpectedQuarter =
      "projectreport/ExpectedQuarter"; // Doanh thu dự kiến  - theo quý
  static const String getExpectedMonth =
      "projectreport/ExpectedMonth"; // Doanh thu dự kiến  - theo tháng
  static const String getExpectedPlan =
      "projectreport/ExpectedPlan"; // Doanh thu dự kiến  - theo kế hoạch

  // quản lý
  static const String getIModule = "projectplan/getimodule"; //
  static const String getProjectPlanIndex =
      "projectplan/index"; // danh sách cơ hội ADMIN
  static const String getGuestPlaceIndex =
      "guestplace/projectplan"; // danh sách cơ hội khách
  static const String getProjectPlanCreate = "projectplan/Create"; // tạo cơ hội
  static const String getSelectCustomer =
      "projectplan/selectCustomer"; // nhóm khách hàng
  static const String getPotentialTypeInfo =
      "projectplan/GetPotentialTypeInfo"; // định nghĩa mức độ đánh giá
  static const String getPotentialSave =
      "projectplan/Save"; //lưu tạo mới cơ hội
  static const String getProjectPlanUpdate =
      "projectplan/Update"; // chỉnh sửa cơ hội
  static const String getProjectPlanChange =
      "projectplan/Change"; // change chỉnh sửa cơ hội
  static const String getDetailKhach =
      "guestplace/projectplandetail"; // chi tiết cơ hội khách
  static const String getDetailAdmin =
      "ProjectPlan/detail"; // chi tiết cơ hội admin
  static const String getDetailHistories =
      "ProjectPlan/Histories"; // lịch sử chi tiết cơ hội
  static const String getDetailChangeStatus =
      "ProjectPlan/ChangeStatus"; // thay đổi trang thái chi tiết
  static const String getDetailChangePhase =
      "ProjectPlan/ChangePhase"; // thay đổi giai đoạn chi tiết
  static const String getContractTrash = "contract/trash"; // Xóa hợp đồng
  static const String getContractRemove =
      "contract/remove"; // Xóa vĩnh viễn hợp đồng
  static const String getContractRestore =
      "contract/restore"; // khôi phục hợp đồng
  static const String getDeleteFileOpportunity =
      "ProjectPlan/DeleteFile"; // xóa file đính kèm
  static const String getDeleteCommentsOpportunity =
      "ProjectPlan/DeleteCmt"; // xóa hoạt động
  static const String projectPlanReject = "projectplan/Reject"; // Reject cơ hội
  static const String projectPlanRemove = "projectplan/remove"; // Remove cơ hội
  static const String projectPlanRestore =
      "projectplan/restore"; // Restore cơ hội
  static const String projectPlanTrash = "projectplan/trash"; // Xoá cơ hội
  static const String projectPlanCopy = "projectplan/copy"; // Xoá cơ hội
  static const String projectPlanApprove =
      "projectplan/Approve"; // Duyệt cơ hội
  static const String getAddCommentsOpportunity =
      "ProjectPlan/AddCmt"; // trả lời hoạt động  chi tiết cơ hội
  static const String getOpportunityImportFile =
      "ProjectPlan/ImportFile"; // thêm file  chi tiết cơ hội
  static const String getOpportunityFileChange =
      "ProjectPlan/FileChange"; // chỉnh sửa file  chi tiết cơ hội
  static const String getProjectPlanCopy =
      "projectplan/copy"; // chỉnh sửa file  chi tiết cơ hội
  static const String getContractCreate = "Contract/Create"; // tạo mới hợp đồng
  static const String getContractSave = "Contract/Save";
  static const String getContractUpdate =
      "Contract/Update"; // chỉnh sửa hợp đồng
  static const String getContractChange = "Contract/Change";
  static const String getContractDetail =
      "contract/detail"; // chi tiết hợp đồng
  static const String getContractSaveAttach =
      "contract/SaveAttach"; // add file hợp đồng
  static const String getContractDeleteAttach =
      "contract/DeleteAttach"; // xóa file hợp đồng
  static const String getContractHistories =
      "Contract/Histories"; // lịch sử hợp đồng
  static const String getContractDeleteCmt =
      "contract/DeleteCmt"; // xóa comment hợp đồng
  static const String getContractAddCmt = "contract/AddCmt"; // comment hợp đồng
  static const String getContractDeletePayment =
      "contract/DeletePayment"; // xóa giai đoạn hợp đồng
  static const String getContractChangePaymentStatus =
      "contract/ChangePaymentStatus"; // trạng thái giai đoạn hợp đồng
  static const String getContractSavePayment =
      "contract/SavePayment"; // tạo giai đoạn hợp đồng
  static const String getContractChangePayment =
      "contract/ChangePayment"; // chính sửa giai đoạn hợp đồng
  static const String getProjectPlanApproveEdit =
      "projectplan/ApproveEdit"; // duyệt chỉnh sửa cơ hội
  static const String getProjectPlanRejectEdit =
      "projectplan/RejectEdit"; // từ chối duyệt chỉnh sửa cơ hội

  // -------------------- Quản lý tài liệu - storage -----------------------//
  // Storage
  static const String storageIndex = "StgFile/Index";

// -------------------- Kế hoạch trọng tâm - OKR -----------------------//
  static const String getListDeptOKR = "dept/index"; // danh sách phòng ban
  static const String getOkrReportDetailReportByColumn =
      "OkrReport/DetailReportByColumn"; //lấy thông tin khi click biểu đồ cột
  static const String getOkrReportDetailReportByPie =
      "OkrReport/DetailReportByPie"; //lấy thông tin khi click biểu đồ tròn
  static const String getOkrReportLoadMoreMission =
      "OkrReport/LoadMoreMission"; //lấy thông tin khi click biểu đồ tròn
  static const String getOkrReportPersonalSummary =
      "OkrReport/PersonalSummary"; //lấy thông tổng kết OKR cá nhân
  static const String getOkrReportProgressTarget =
      "OkrReport/ProgressTarget"; //lấy thông tổng kết OKR cá nhân
  static const String getListUserFilterOkr = "user/index"; // danh sachs cá nhân
  static const String getOkrPlanIndex =
      "okrplan/index"; // danh sách kế hoạch và duyệt kế hoạch
  static const String getOkrPlanDelete =
      "okrplan/Delete"; // xóa danh sách kế hoạch
  static const String getOkrReportDashboard =
      "OkrReport/Dashboard"; // lấy thông tin dashboard
  static const String getOkrPlanCreate = "okrplan/Create"; // tạo kế hoạch
  static const String getOkrPlanSave = "okrplan/Save"; // lưu kế hoạch
  static const String getCaculateTime =
      "okrplan/CaculateTime"; // Quy định thời gian gửi
  static const String getCreateTargetScr =
      "okrplan/CreateTargetScr"; // Mục tiêu từ kế hoạch
  static const String getOkrPlanDetail =
      "okrplan/Detail"; // chi tiết - duyệt chi tiết - chỉnh sửa kế hoạch
  static const String getOkrPlanHistory =
      "okrplan/PlanChangeHistory"; // lịch sử diều chỉnh kế hoạch
  static const String getOkrPlanApproved = "okrplan/Approved"; // duyệt kế hoạch
  static const String getOkrPlanReject =
      "okrplan/Reject"; // Từ chối duyệt kế hoạch
  static const String getOkrPlanSendApproved =
      "okrplan/SendApproved"; // data gửi mail kế hoạch
  static const String getOkrPlanSendApprovedSave =
      "okrplan/SendApprovedSave"; // lưu mail kế hoạch công ty
  static const String getOkrPlanAgreeChange =
      "okrplan/AgreeChange"; // đồng ý kế hoạch
  static const String getOkrPlanRejectChange =
      "okrplan/RejectChange"; // từ chối chi tiết kế hoạch
  static const String getOkrPlanApprovedDetail =
      "okrplan/ApprovedDetail"; // xem Chi tiết duyệt kế hoạch
  static const String getOkrReportIndex =
      "OkrReport/index"; // danh sách báo cáo
  static const String getOkrReportDetail =
      "OkrReport/detail"; // chi tiết cáo cáo
  static const String getOkrReportSave = "OkrReport/save"; // lưu báo cáo
  static const String getOkrReportSendApprovedSave =
      "OkrReport/SendApprovedSave"; // gửi mail báo cáo
  static const String getOkrReportSendApproved =
      "OkrReport/SendApproved"; // data gửi mail báo cáo
  static const String getOkrReportChat = "OkrReport/Chat"; // danh sách trao đổi
  static const String getOkrReportAddComment =
      "OkrReport/AddCmt"; // thêm bình luận trao đổi
  static const String getOkrReportDeleteComment =
      "OkrReport/DeleteCmt"; // xóa bình luận trao đổi
  static const String getOkrReportChangeHistory =
      "OkrReport/ChangeHistory"; //danh sách lịch sử cập nhật báo cáo
  static const String getOkrReportChangeHistoryDetail =
      "OkrReport/ChangeHistoryDetail"; // chi tiết lịch sử cập nhật báo cáo
  static const String getOkrReportApproved =
      "OkrReport/Approved"; //đồng ý duyệt báo cáo
  static const String getOkrReportReject =
      "OkrReport/Reject"; // từ chối duyệt báo cáo
  static const String getOkrReportApprovedDetail =
      "OkrReport/ApprovedDetail"; //chi tiết duyệt báo cáo
  static const String getOkrReportRejectChange =
      "OkrReport/RejectChange"; // người lập báo cáo nhấn từ chối kết quả chỉnh sửa
  static const String getOkrReportAgreeChange =
      "OkrReport/AgreeChange"; // người lập báo cáo nhấn đồng ý chỉnh sửa
  static const String getOkrPlanQuickApproved =
      "okrplan/QuickApproved"; // Api duyệt kế hoạch sử dụng trường hợp duyệt nhanh ngoài màn hình danh sách duyệt
  static const String getOkrReportQuickApproved =
      "OkrReport/QuickApproved"; // Api duyệt báo cáo sử dụng trường hợp duyệt nhanh ngoài màn hình danh sách duyệt
  static const String getGetIModuleOKR =
      "KhttWfl/GetIModule"; //Lấy quyền truy cập module
  static const String getVersionReport =
      "OkrReport/GetVersionReport"; //danh sách lịch sử phiên bản
  static const String getClonePlanScr =
      "OkrPlan/ClonePlanScr"; //Api lấy danh sách các kế hoạch để sao chép
  static const String getCloneMission =
      "OkrPlan/CloneMission"; //Api lấy chi tiết kế hoạch cần sao chép
  static const String getUpdateCmtReaded =
      "OkrReport/UpdateCmtReaded"; //Api cập nhật trạng thái của trao đổi/bình luận sang đã đọc
  static const String getMissionByStatus =
      "OkrReport/MissionByStatus"; //click từ thống kê qua chi tiết báo cáo
}
