import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static Flushbar _flushbar;

  static success(BuildContext context, String message,
      {bool popAfterWards = false, String title = 'Success'}) async {
    print('showing flushbar');
    close(context);

    _flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      title: title,
      message: message,
      backgroundColor: Colors.green[700],
      duration: Duration(milliseconds: 1500),
    );
    await _flushbar.show(context);

    if (popAfterWards ?? false) Navigator.pop(context);
  }

  static error(
      BuildContext context,
      String message,
      ) async {
    _flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      title: 'Error',
      message: message,
      backgroundColor: Theme.of(context).errorColor,
      duration: Duration(milliseconds: 1500),
    );
    await _flushbar.show(context);
  }

  static show(context,
      {String title = 'Upload',
        String message = 'Uploading images...',
        bool error = false}) {
    if (_flushbar != null) _flushbar.dismiss();

    _flushbar = Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        title: title,
        isDismissible: true,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        message: message,
        backgroundColor: (error)
            ? Theme.of(context).errorColor
            : Theme.of(context).primaryColor);
    _flushbar.show(context);
  }

  static close(context) {
    if (_flushbar != null) _flushbar.dismiss();
    // _flushbar = null;
  }
}
