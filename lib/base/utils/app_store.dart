import 'package:workflow_manager/manager/models/response/home_index_response.dart';

class AppStore {

  static bool isLogoutState = false;

  static int isViewDeadLine =
      0; // phân biệt chế độ hiển thị Trạng thái công việc hay Theo dõi ngày kết thúc

  static int currentViewTypeWorkflow =
      1; // phân biệt các tab Được giao, đã giao, phối hợp ...


  static String AppleID = "1548095234";

  static HomeIndexData homeIndexData; // Hiển thị đồ thị của trang home
  static int countNotify = 0;

  static int idNotify = 0;

  static String copyRight = "";
}