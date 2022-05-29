import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'text_custom.dart';

class BaseDialog {
  static var _isShowingAlertDialog = false;
  static var _isShowingInfoDialog = false;

  static const _dialogContentMaxLine = 3;

  //Dialog
  static void showAlertDialog(String message,
      {VoidCallback? onConfirm, VoidCallback? onCancel}) {
    if (_isShowingAlertDialog) return;
    _isShowingAlertDialog = true;
    Get.defaultDialog(
        title: 'error'.tr,
        titleStyle: const TextStyle(color: Colors.red),
        barrierDismissible: false,
        content: TextCustom(
          message,
          maxLines: _dialogContentMaxLine,
        ),
        textCancel: 'cancel'.tr,
        onWillPop: () async {
          _isShowingAlertDialog = false;
          return true;
        },
        onConfirm: onConfirm != null
            ? () {
                Get.back();
                onConfirm();
                _isShowingAlertDialog = false;
              }
            : null,
        onCancel: () {
          _isShowingAlertDialog = false;
          if (onCancel != null) onCancel();
        });
  }

  static void showInfoDialog(String message,
      {VoidCallback? onConfirm, VoidCallback? onCancel}) {
    if (_isShowingInfoDialog) return;
    _isShowingInfoDialog = true;
    Get.defaultDialog(
        title: 'info'.tr,
        titleStyle: const TextStyle(color: Colors.blue),
        content: TextCustom(
          message,
          maxLines: _dialogContentMaxLine,
        ),
        barrierDismissible: false,
        textCancel: 'cancel'.tr,
        onWillPop: () async {
          _isShowingInfoDialog = false;
          return true;
        },
        onConfirm: onConfirm != null
            ? () {
                _isShowingInfoDialog = false;
                Get.back();
                onConfirm();
              }
            : null,
        onCancel: () {
          _isShowingInfoDialog = false;
          if (onCancel != null) onCancel();
        });
  }

  static void showWarningDialog(String message,
      {VoidCallback? onConfirm, VoidCallback? onCancel}) {
    Get.defaultDialog(
        title: 'warning'.tr,
        titleStyle: const TextStyle(color: Colors.yellow),
        content: TextCustom(
          message,
          maxLines: _dialogContentMaxLine,
        ),
        textCancel: 'cancel'.tr,
        onConfirm: onConfirm != null
            ? () {
                Get.back();
                onConfirm();
              }
            : null,
        onCancel: () {
          if (onCancel != null) onCancel();
        });
  }

  static void showUpdateAppDialog(String message,
      {VoidCallback? onConfirm, bool isForce = true}) {
    Get.defaultDialog(
        title: 'info'.tr,
        titleStyle: const TextStyle(color: Colors.blue),
        content: TextCustom(
          message,
          maxLines: _dialogContentMaxLine,
        ),
        textConfirm: 'update'.tr,
        textCancel: 'cancel'.tr,
        barrierDismissible: false,
        onConfirm: onConfirm != null
            ? () {
                Get.back();
                onConfirm();
              }
            : null,
        onCancel: isForce == false
            ? () {
                Get.back();
              }
            : null);
  }

  /// Snackbar
  static void showErrorSnackbar(
      {required String title, required String content}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }

  static void showSuccessSnackbar(
      {required String title, required String content}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  static void showInfoSnackbar(
      {required String title, required String content}) {
    Get.closeCurrentSnackbar();
    Get.snackbar(title, content,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey[300],
        colorText: Colors.black);
  }
}
