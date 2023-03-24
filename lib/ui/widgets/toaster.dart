import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

buildToaster({required String message, Color? color}) {
  return Fluttertoast.showToast(
      msg: message, backgroundColor: color ?? Colors.white);
}
