class NotificationType {
  static NotificationType _instance;

  static NotificationType get instance {
    if (_instance == null) {
      _instance = NotificationType();
    }
    return _instance;
  }

  /// Quả lý tài liệu
  //Quản lý tài liệu
  bool isStorage(int type) {
    return type == 4;
  }

  //chia sẻ thư mục | tài liệu cá nhân
  bool isShareDoc(int type) {
    return type == 2;
  }

  /// Quản lý công việc
  //Chi tiết công việc
  bool isDetailJob(int type) {
    return type == 273;
  }

  //Chi tiết nhóm công việc
  bool isDetailGroupJob(int type) {
    return type == 278;
  }

  /// Mượn trả tài liệu
  //Chi tiết mượn trả tài liệu
  bool isDetailBorrow(int type) {
    return type == 63 ||
        type == 20 ||
        type == 21 ||
        type == 22 ||
        type == 26 ||
        type == 27;
  }

  //MƯỢN TRẢ TÀI LIỆU - CHỜ DUYỆT
  bool isBorrowPending(int type) {
    return type == 63;
  }

  //MƯỢN TRẢ TÀI LIỆU - ĐÃ DUYỆT
  bool isBorrowApproved(int type) {
    return type == 20;
  }

  //MƯỢN TRẢ TÀI LIỆU - ĐÃ TRẢ
  bool isBorrowClosed(int type) {
    return type == 22;
  }

  //MƯỢN TRẢ TÀI LIỆU - THU HỒI
  bool isBorrowDisabled(int type) {
    return type == 27;
  }

  //MƯỢN TRẢ TÀI LIỆU - TỪ CHỐI
  bool isBorrowRejected(int type) {
    return type == 26;
  }

  bool isDownloadFile(int type) {
    return type == 5;
  }

  //MƯỢN TRẢ TÀI LIỆU - XEM FILE
  bool isOpenFile(int type) {
    return type == 21;
  }

  bool zipFolderEmpty(int type) {
    return type == 25;
  }

  /// Quy trình thủ tục
  //Chi tiết đăng ký
  bool isDetailRegister(int type) {
    return type == 43;
  }

  //Chi tiết giải quyết
  bool isDetailResolve(int type) {
    return type == 36;
  }

  ///Quản lý kinh doanh
  //Chi tiết quản lý kinh doanh
  bool isDetailBusiness(int type) {
    return type == 65;
  }

  ///Quản lý dự án
  //Yêu cầu deploy dự án ?
  bool isRequestDeployPlan(int type) {
    return type == 53;
  }

  bool isDetailPlan(int type) {
    return type == 48;
  }

  bool isNoNavigation(int type) {
    return type == 279;
  }

  //TODO BEGIN TCP Module 8-1-2022
  ///TCP Module 1
  //Chi tiết lệnh công tác
  bool isDetailWorkCommand(int type) {
    return type == 5014 ||
        type == 5015 ||
        type == 5016 ||
        type == 5017 ||
        type == 5018 ||
        type == 5025 ||
        type == 5026 ||
        type == 5053;
  }

  ///TCP Module 2
  //Chi tiết phiếu công tac
  bool isDetailWorkSheet(int type) {
    return type == 5019 ||
        type == 5020 ||
        type == 5021 ||
        type == 5022 ||
        type == 5023 ||
        type == 5024 ||
        type == 5047 ||
        type == 5048 ||
        type == 5049 ||
        type == 5055;
  }

  ///TCP Module 3
  //Chi tiết lệnh công tác CNH
  bool isDetailMechanicalWorkCommand(int type) {
    return type == 5029 ||
        type == 5030 ||
        type == 5031 ||
        type == 5032 ||
        type == 5033 ||
        type == 5034 ||
        type == 5035 ||
        type == 5054;
  }

  ///TCP Module 4
  //Chi tiết phiếu công tac CNH
  bool isDetailMechanicalWorkSheet(int type) {
    return type == 5036 ||
        type == 5037 ||
        type == 5038 ||
        type == 5039 ||
        type == 5040 ||
        type == 5041 ||
        type == 5050 ||
        type == 5051 ||
        type == 5052 ||
        type == 5056;
  }

  ///TCP Module 5
  //Chi tiết phiếu thao tác
  bool isDetailManipulationSheet(int type) {
    return type == 5027 || type == 5028;
  }

  ///TCP Module 6
  //Chi tiết tiếp nhận hồ sơ dầu
  bool isDetailManagerReceivingOil(int type) {
    return type == 5042;
  }

  ///TCP Module 7
  //Chi tiết tiếp nhận hồ sơ đá vôi
  bool isDetailManagerReceivingLimestone(int type) {
    return type == 5043 || type == 5044;
  }
  //TODO END TCP Module 8-1-2022
}
