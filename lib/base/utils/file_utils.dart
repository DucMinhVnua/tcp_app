import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workflow_manager/app_init.dart';
import 'package:workflow_manager/base/extension/string.dart';
import 'package:workflow_manager/base/ui/bottom_sheet_dialog.dart';
import 'package:workflow_manager/base/ui/toast_view.dart';
import 'package:workflow_manager/base/ui/webview_screen.dart';
import 'package:workflow_manager/base/utils/common_function.dart';
import 'package:workflow_manager/storage/utils/ImageUtils.dart';
import 'package:workflow_manager/tpc/models/directory_path.dart';
import 'package:workflow_manager/tpc/models/file_response.dart';
import 'package:workflow_manager/tpc/models/response/pair_reponse.dart';
import 'package:workflow_manager/tpc/models/response/upload_response.dart';

import '../../tpc/models/directory_path.dart';
import '../network/api_caller.dart';
import 'base_sharepreference.dart';

class FileUtils {
  static FileUtils _instance;

  static FileUtils get instance {
    if (_instance == null) {
      _instance = FileUtils();
    }
    return _instance;
  }

  // download và mở file
  Future<String> downloadFileAndOpen(
      String fileName, String filePath, BuildContext context,
      {int typeExtension,
        bool isOpenFile = true,
        bool isShowSuccess = true,
        bool isStorage = true,
        bool isNeedToken = false,
        bool isAutoDetectFileName = false}) async {
    fileName = _updateExtensionName(filePath, fileName);

    String newPath = "";
    if (filePath.toLowerCase().startsWith("/storage/files/")) {
      newPath = filePath.toLowerCase().replaceAll("/storage/files/", "");
    } else {
      newPath = filePath;
    }
    String newName = "";
    if (isNotNullOrEmpty(typeExtension)) {
      if (newPath
          .toLowerCase()
          .contains(ImageUtils.instance.returnExtensionName(typeExtension))) {
        newName = fileName.replaceAll(
            ImageUtils.instance.returnExtensionName(typeExtension), "");
        newName =
        "${newName}${ImageUtils.instance.returnExtensionName(typeExtension)}";
      }
    } else {
      newName = fileName;
    }
    String root =
    await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
    String url = '${newPath}';
    if (!url.startsWith("http")) {
      url = '$root/storage/files/${newPath}';
    }
    if (!isStorage) {
      // Nếu download từ link thi ghép thêm root vào
      url = '$root${newPath.startsWith("/") ? newPath : "/$newPath"}';
    }
    if (isNeedToken)
      url += "${url.contains("?") ? "&" : "?"}token=" +
          await SharedPreferencesClass.getToken();
    String path = await FileUtils.instance
        .downloadFile(url, newName, isAutoDetectFileName: isAutoDetectFileName);
    print("===========> ${path}");

    if (path.isNotNullOrEmpty) {
      try {
        if (isOpenFile) {
          var result = await OpenFile.open(path);
          if (result.type == ResultType.noAppToOpen) {
            // quỳnh sửa lại phần này trong QLKD - chi tiết cơ hội, hợp đồng - xem file
            // do cái path đang cộng fileName lên không hiên thị file
            // tk hn_dev_nv1, id chi tiết cơ hội: 18351
            // không biết có đúng trong các trường hợp khác hay không, QLKD chạy dc
            String aaaa = '$root/storage/files/${newPath}';
            pushPage(context, WebViewScreen(true, title: newName, url: aaaa));
            // pushPage(context, WebViewScreen(title: newName, url: path));
          }
        } else {
          if (isShowSuccess)
            ToastMessage.show("Tải file thành công", ToastStyle.success);
        }
      } on Exception catch (e) {
        print("Exception=>  ${e.toString()}");
      }
    } else {
      ToastMessage.show("Tải file thất bại.", ToastStyle.error);
    }
    return path;
  }

  String _updateExtensionName(String filePath, String fileName) {
    var extensionPath = p.extension(filePath);
    var extensionName = p.extension(fileName);
    if (isNullOrEmpty(extensionName)) {
      fileName = fileName + extensionPath;
    } else if (extensionName != extensionPath) {
      fileName = fileName.replaceAll(extensionName, extensionPath);
    }
    return fileName;
  }

  Future<File> pdfAsset() async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/set_any_name.pdf');
    ByteData bd = await rootBundle.load('assets/en/legal_notes.pdf');
    await tempFile.writeAsBytes(bd.buffer.asUint8List(), flush: true);
    return tempFile;
  }

  // Dùng hàm downloadFileAndOpen để down files rồi mở luôn
  Future<String> downloadFile(String filePath, String fileName,
      {void Function(int) onProgress,
        bool isAutoDetectFileName = false}) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        print("${status.isGranted} ${permissionStatus.isGranted}");
        if (!permissionStatus.isGranted) {
          ToastMessage.show(
              'Bạn cần cung cấp quyền đọc ghi để tải và xem file.',
              ToastStyle.error);
          return null;
        }
      }
      if (fileName.contains("/"))
        fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
      String savePath = fileName;
      savePath = await getSaveDirectory(fileName: savePath);
      bool isSuccess = await ApiCaller.instance.downloadFile(filePath, savePath,
          receiverListener: (total, progress, percent) {
            print('percent:       $percent');
          }, isAutoDetectFileName: isAutoDetectFileName);
      if (isSuccess) return savePath;
      print("download fail url:  $filePath   path:$savePath");
    } on Exception {
      var device = await DeviceInfoPlugin().androidInfo;
      if (["10", "11"].contains(device.version.release))
        showErrorToast(
            "Máy bạn đang dùng android ${device.version.release}, Chúng tôi hiện chưa hỗ trợ bản android này, chúng tôi sẽ cố gắng hỗ trợ trong thời gian sớm nhất.");
    }
    return null;
  }

  Future<String> getSaveDirectory({String fileName}) async {
    String directory;
    if (Platform.isAndroid) {
      var deviceInfo = await DeviceInfoPlugin().androidInfo;
      String downloadPath;
      if (deviceInfo.version.sdkInt > 28) {
        Directory osDirectory = await getApplicationDocumentsDirectory();
        downloadPath = osDirectory.path;
      } else {
        DirectoryPath directoryPath = await getDirectory();
        downloadPath = directoryPath.RootSdcard;
      }
      directory =
      '${downloadPath}/FSIS${isNullOrEmpty(fileName) ? "" : "${fileName.startsWith("/") ? "" : "/"}$fileName"}';
      var file = File(directory);
      if (await file.exists()) file.deleteSync();
      if (!(await Directory('${downloadPath}/FSIS/').exists())) {
        await Directory("${downloadPath}/FSIS/").create(recursive: true);
      }
    } else {
      Directory osDirectory = await getApplicationDocumentsDirectory();
      osDirectory.create(recursive: true);
      directory =
      "${osDirectory.path}${isNullOrEmpty(fileName) ? "/" : "${fileName.startsWith("/") ? "" : "/"}$fileName"}";
    }
    return directory;
  }

  Future<void> downloadFileToInternalStorage(
      String fileName, String url) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      String path = '${dir.path}/FSIS/$fileName';
      print("downloadFileToInternalStorage path $path");
      await dio.download(url, path, onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
      });
    } catch (e) {
      print(e);
    }
    print("downloadFileToInternalStorage Download completed");
  }

  Future<void> launchInBrowser(String url, {BuildContext context}) async {
    print('OpenFileWithUrl: $url');
    // url = url.toLowerCase();
    // if (url.contains('.jpg') || url.contains('.jpeg') || url.contains('.png')) {
    //   pushPage(context, ImageFullScreenWidget(url));
    // } else {
    //   url = 'http://docs.google.com/viewer?url=$url';
    //   if (await canLaunch(url)) {
    //     await launch(
    //       url,
    //       forceSafariVC: true,
    //       forceWebView: true,
    //     );
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }
  }

  Future<UploadModel> uploadFileFromSdcard(BuildContext context,
      {FileType fileType,
        List<String> allowExtentions,
        List<String> notAllowFileName}) async {
    try {
      UploadModel uploadModel;
      if (fileType == null && Platform.isIOS) {
        if (isNotNullOrEmpty(allowExtentions)) {
          uploadModel = await uploadFile(FileType.custom,
              allowExtentions: allowExtentions,
              notAllowFileNames: notAllowFileName);
          return uploadModel;
        } else {
          BottomSheetDialog bottomSheetDialog = BottomSheetDialog(
            context: context,
            onTapListener: (item) async {
              if (item.key == 1) {
                uploadModel = await uploadFile(FileType.image,
                    allowExtentions: allowExtentions,
                    notAllowFileNames: notAllowFileName);
              } else {
                uploadModel = await uploadFile(FileType.any,
                    allowExtentions: allowExtentions,
                    notAllowFileNames: notAllowFileName);
              }
            },
          );
          List<Pair> list = [
            Pair(key: 1, value: "Ảnh / Video"),
            Pair(key: 2, value: "Tài liệu / Files"),
          ];
          await bottomSheetDialog.showBottomSheetDialog(list);
        }
        return uploadModel;
      }
      return await uploadFile(fileType ?? FileType.any,
          allowExtentions: allowExtentions,
          notAllowFileNames: notAllowFileName);
    } on Exception {
      var device = await DeviceInfoPlugin().androidInfo;
      if (["10", "11"].contains(device.version.release))
        showErrorToast(
            "Máy bạn đang dùng android ${device.version.release}, Chúng tôi hiện chưa hỗ trợ bản android này, chúng tôi sẽ cố gắng hỗ trợ trong thời gian sớm nhất.");
    }
  }

  Future<UploadModel> uploadFile(FileType type,
      {List<String> allowExtentions, List<String> notAllowFileNames}) async {
    FilePickerResult result;
    if (isNotNullOrEmpty(allowExtentions)) {
      result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: allowExtentions);
    } else
      result = await FilePicker.platform.pickFiles(type: type);
    if (result == null || result.files.length == 0) {
      return UploadModel(uploadStatus: UploadStatus.cancel);
    }
    if (notAllowFileNames?.contains(result.names[0]) == true) {
      return UploadModel(uploadStatus: UploadStatus.file_name_existed);
    }
    String root =
    await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
    var pathFile = result.files[0].path;
    print("XXuploadFile pathFile = ${pathFile}");
    var params = {
      "FileDocument": await MultipartFile.fromFile(pathFile,
          filename: getFileName(pathFile)),
      'IsMobile': '1'
    };
    var response =
    await ApiCaller.instance.uploadFile("${root}/uploader/upfile", params);
    UploadResponse uploadResponse = UploadResponse.fromJson(response);
    if (uploadResponse.status == 1) {
      if (uploadResponse.data.fileName.startsWith("/"))
        uploadResponse.data.fileName =
            uploadResponse.data.fileName.substring(1);
      uploadResponse.data.uploadStatus = UploadStatus.upload_success;
      uploadResponse.data.filePathRoot = pathFile;
      return uploadResponse.data;
    } else {
      // return UploadModel(uploadStatus: UploadStatus.upload_failure);
      ToastMessage.show(uploadResponse.messages, ToastStyle.error);
      return null;
    }
  }

  Future<UploadModel> uploadFileWithPath(String pathFile) async {
    String root =
    await SharedPreferencesClass.get(SharedPreferencesClass.ROOT_KEY);
    var params = {
      "FileDocument": await MultipartFile.fromFile(pathFile,
          filename: getFileName(pathFile)),
      'IsMobile': '1'
    };
    var response =
    await ApiCaller.instance.uploadFile("${root}/uploader/upfile", params);
    UploadResponse uploadResponse = UploadResponse.fromJson(response);
    if (uploadResponse.status == 1) {
      if (uploadResponse.data.fileName.startsWith("/"))
        uploadResponse.data.fileName =
            uploadResponse.data.fileName.substring(1);
      uploadResponse.data.uploadStatus = UploadStatus.upload_success;
      uploadResponse.data.filePathRoot = pathFile;
      return uploadResponse.data;
    } else {
      return UploadModel(uploadStatus: UploadStatus.upload_failure);
    }
  }

  String getStringFileName(List<FileModel> files) {
    String fileName = '';
    for (int i = 0; i < files.length; i++) {
      if (fileName.length == 0) {
        fileName = "\'" + files[i].name + "\'";
      } else {
        fileName = fileName + ",\'" + files[i].name + "\'";
      }
    }
    return "[$fileName]";
  }

  String getStringFilePath(List<FileModel> files) {
    String filePath = '';
    for (int i = 0; i < files.length; i++) {
      if (filePath.length == 0) {
        filePath = "\'" + files[i].path + "\'";
      } else {
        filePath = filePath + ",\'" + files[i].path + "\'";
      }
    }
    return "[$filePath]";
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName.pdf';
    return path;
  }

  String getFileName(String filePath) {
    int index = filePath.lastIndexOf("/");
    if (index == -1) {
      return filePath;
    }
    String fileName = filePath.substring(index);
    if (fileName.length == 0) return "file ";
    return fileName;
  }

  Future<DirectoryPath> getDirectory() async {
    final String method = "getDirectory";
    String response = "";
    try {
      final String result = await platform.invokeMethod(method);
      DirectoryPath path = DirectoryPath();
      path.RootSdcard = result;
      return path;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    return null;
  }

  String getListStringConvertString(List<String> listString) {
    String s;
    if (isNullOrEmpty(listString) || listString.length == 0) return '';
    listString.forEach((element) {
      if (element == null) element = '';

      if (s == null) {
        s = element;
      } else {
        s = s + ',' + element;
      }
    });

    return s;
  }
}