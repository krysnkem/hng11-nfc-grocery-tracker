import 'package:flutter/material.dart';
import 'package:grocey_tag/utils/snack_message.dart';

showStatusSnackBar({required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: toast(message),
      backgroundColor: Colors.transparent,
    ),
  );
}

showErrorSnackBar({required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: toast(message, success: false),
      backgroundColor: Colors.transparent,
    ),
  );
}
