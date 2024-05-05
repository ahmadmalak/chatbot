import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required message,
  required BuildContext context,
}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black.withOpacity(0.8),
    textColor: Colors.white,
    fontSize: 16,
    gravity: ToastGravity.CENTER_LEFT,
  );
}
