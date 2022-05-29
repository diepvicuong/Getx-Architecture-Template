import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../utils/logger.dart';
import '../views/widgets/dialog_custom.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

class ConnectivityService extends GetxController {
  ConnectivityStatus status = ConnectivityStatus.Offline;
  bool _isConnected = false;

  ConnectivityStatus get statusValue => status;

  bool get isConnected => _isConnected;

  bool isErrorShowing = false;

  ConnectivityService._privateConstructor();

  static final ConnectivityService connectivityService =
      ConnectivityService._privateConstructor();

  ConnectivityService() {
    Connectivity().checkConnectivity().then((result) {
      MyLogger.d(result);
      //_connectivityEvent(result);
      status = _getStatusFromResult(result);
    });
    checkConnection(isShowError: true).then((value) => {
          _isConnected = value,
        });
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      _connectivityEvent(result);
    });
  }

  Future<bool> checkConnection({bool isShowError = true}) async {
    ConnectivityResult connectivityStatus =
        await Connectivity().checkConnectivity();
    if (connectivityStatus != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (isErrorShowing) {
            // Navigator.of(navigatorKey.currentState.overlay.context).pop();
            // isErrorShowing = false;
          }
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        if (!isErrorShowing && isShowError) {
          _showDialogErrorNetwork();
          // isErrorShowing = true;
        }
        return false;
      }
    } else {
      if (!isErrorShowing && isShowError) {
        _showDialogErrorNetwork();
        // isErrorShowing = true;
      }
      return false;
    }
  }

  _connectivityEvent(ConnectivityResult result) async {
    status = _getStatusFromResult(result);
    MyLogger.d('Connectivity status: $status');
    if (result != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (isErrorShowing) {
            // Navigator.of(navigatorKey.currentState.overlay.context).pop();
            // isErrorShowing = false;
          }
          _isConnected = true;
        } else {
          _isConnected = false;
        }
      } on SocketException catch (_) {
        if (!isErrorShowing) {
          _showDialogErrorNetwork();
          // isErrorShowing = true;
        }
      }
    } else {
      if (!isErrorShowing) {
        _showDialogErrorNetwork();
        // isErrorShowing = true;
      }
      _isConnected = false;
    }
    // eventBus.fire(ConnectivityStatusEvent(_isConnected ? ConnectivityStatusType.Connected : ConnectivityStatusType.Disconnected));
  }

  _showDialogErrorNetwork() {
    // BaseDialog.showErrorSnackbar(title: 'error'.tr, content: 'noInternet'.tr);
    BaseDialog.showAlertDialog('noInternet'.tr);
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Future<bool> getStatusConnected() async {
    bool _status = false;
    await checkConnection(isShowError: false).then((value) => _status = value);
    return _status;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
