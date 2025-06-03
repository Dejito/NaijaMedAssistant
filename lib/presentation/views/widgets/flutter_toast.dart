import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

showToast({
  required String message,
  Color backgroundColor = Colors.white,
  Color textColor = Colors.black,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
    textColor: textColor
  );
}
