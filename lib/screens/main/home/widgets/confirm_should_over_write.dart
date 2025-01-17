import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';

Future<bool> confirmShouldOverWrite(BuildContext context, {String? title}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? 'Your tag is not empty'),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Do you want to overwrite it?'),
          16.sp.sbH,
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  ).then(
    (value) => value ?? false,
  );
}
