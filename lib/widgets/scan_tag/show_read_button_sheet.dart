import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/services/nfc_service.dart';
import 'package:grocey_tag/utils/app-bottom-sheet.dart';

import 'read_nfc_widget.dart';

Future<NFCReadResult> showReadButtonSheet({
  required BuildContext context,
}) {
  return appBottomSheet<NFCReadResult>(const ReadNFCWidget(), height: 462.sp)
      .then(
    (value) =>
        value ??
        NFCReadResult(
          status: NfcReadStatus.cancel,
        ),
  );
}
