class CustomException implements Exception {
  String errorMsgKey;
  dynamic exception;
  StackTrace? stack;

  CustomException(this.errorMsgKey, {this.exception, this.stack}) {
    _init();
  }

  Future _init() async {
    //TODO: Logging error
    // FirebaseCrashlytics.instance
    //     .recordError(this.exception, this.stack, reason: this.errorMsgKey);
  }
}
