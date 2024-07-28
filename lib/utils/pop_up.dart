import 'package:flutter/material.dart';

import '../core/constants/constants.dart';
import '../widgets/bottomSheet.dart';
import 'action-pop-up.dart';

popUp(String title, Function onTap, {String? subtitle}) async {
  BuildContext context = navigationService.navigatorKey.currentState!.context;
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    builder: (_) => BottomSheetScreen(
        child: PopUpDialog(
          title: title,
          onTap: onTap,
          subTitle: subtitle,
        )),
  );
}