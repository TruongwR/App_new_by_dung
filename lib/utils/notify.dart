import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageType {
  error,
  warning,
  success,
  normal,
}

class Notify {
  static success(String message) {
    show(message, type: MessageType.success);
  }

  static warning(String message) {
    show(message, type: MessageType.warning);
  }

  static error(String message) {
    show(message);
  }

  static show(String message,
      {MessageType type = MessageType.error, position = SnackPosition.BOTTOM}) {
    Color bgColor = Colors.grey;
    Icon icon = const Icon(Icons.info, color: Colors.white);
    switch (type) {
      case MessageType.error:
        bgColor = Colors.red[600]!;
        icon = const Icon(Icons.error, color: Colors.white);
        break;
      case MessageType.warning:
        bgColor = Colors.orange[300]!;
        icon = const Icon(Icons.warning, color: Colors.white);
        break;
      case MessageType.success:
        bgColor = Colors.green[400]!;
        icon = const Icon(
          Icons.check,
          color: Colors.white,
        );
        break;
      default:
        break;
    }

    Get.rawSnackbar(
        message: message,
        backgroundColor: bgColor,
        icon: icon,
        animationDuration: const Duration(milliseconds: 200),
        snackPosition: position);
  }

  static SnackBar getSnackBar(String message, MessageType type) {
    Color bgColor = Colors.grey;
    switch (type) {
      case MessageType.error:
        bgColor = Colors.red[600]!;
        break;
      case MessageType.warning:
        bgColor = Colors.orange[300]!;
        break;
      case MessageType.success:
        bgColor = Colors.green[400]!;
        break;
      default:
        break;
    }

    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: bgColor,
    );
  }
}
