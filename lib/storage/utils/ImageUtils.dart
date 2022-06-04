import 'package:workflow_manager/base/utils/common_function.dart';

class ImageUtils {
  static ImageUtils _instance;

  static ImageUtils get instance {
    if (_instance == null) {
      _instance = ImageUtils();
    }
    return _instance;
  }

  String returnExtensionName(int typeExtension) {
    switch (typeExtension) {
      case 1:
        return '.pdf';
      case 2:
        return '.bmp';
      case 3:
        return '.doc';
      case 4:
        return '';
      case 5:
        return '.gif';
      case 6:
        return '.html';
      case 7:
        return '.jpg';
      case 8:
        return '.mp3';
      case 9:
        return '.mp4';
      case 10:
        return '.png';
      case 11:
        return '.ppt';
      case 12:
        return '.png';
      case 13:
        return '.tip';
      case 14:
        return '.txt';
      case 15:
        return '.xls';
      default:
        return '';
    }
  }

  String checkImageFileWith(int typeExtension) {
    switch (typeExtension) {
      case 1:
        return 'assets/images/pdf.png';
      case 2:
        return 'assets/images/bmp.png';
      case 3:
        return 'assets/images/doc.png';
      case 4:
        return 'assets/images/folder.png';
      case 5:
        return 'assets/images/gif.png';
      case 6:
        return 'assets/images/html.png';
      case 7:
        return 'assets/images/jpg.png';
      case 8:
        return 'assets/images/mp3.png';
      case 9:
        return 'assets/images/mp4.png';
      case 10:
        return 'assets/images/png.png';
      case 11:
        return 'assets/images/ppt.png';
      case 12:
        return 'assets/images/png.png';
      case 13:
        return 'assets/images/tip.png';
      case 14:
        return 'assets/images/txt.png';
      case 15:
        return 'assets/images/xls.png';
      default:
        return 'assets/images/unknown.png';
    }
  }

  String getImageType(String fileName) {
    if (isNullOrEmpty(fileName)) return 'assets/images/unknown.png';
    if (fileName.contains(".pdf")) {
      return 'assets/images/pdf.png';
    } else if (fileName.contains(".pdf")) {
      return 'assets/images/pdf.png';
    } else if (fileName.contains(".doc") || fileName.contains(".docx")) {
      return 'assets/images/doc.png';
    } else if (fileName.contains(".jpg") ||
        fileName.contains(".jpeg") ||
        fileName.contains(".png")) {
      return 'assets/images/jpg.png';
    } else if (fileName.contains(".mp3")) {
      return 'assets/images/mp3.png';
    } else if (fileName.contains(".mp4") ||
        fileName.contains(".3gp") ||
        fileName.contains(".mpg") ||
        fileName.contains(".mpeg")) {
      return 'assets/images/mp4.png';
    } else if (fileName.contains(".ppt") || fileName.contains(".pptx")) {
      return 'assets/images/ppt.png';
    } else if (fileName.contains(".txt")) {
      return 'assets/images/txt.png';
    } else if (fileName.contains(".xls") || fileName.contains(".xlsx")) {
      return 'assets/images/xls.png';
    } else {
      return 'assets/images/unknown.png';
    }
  }
}
