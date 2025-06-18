import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

class ToastUtils {
  static showToast(String message) {
    toastification.show(
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
    );

  }
}