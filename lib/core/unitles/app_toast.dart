import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? 'Success'),
      description: Text(message),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }

  static void showFailure({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? 'Error'),
      description: Text(message),
      alignment: Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }
}
